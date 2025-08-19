import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/data/request/request_user_auth.dart';
import 'package:my_app/core/providers/auth_providers.dart';
import 'package:my_app/core/services/platform/device_info_service.dart';
import 'package:my_app/core/services/platform/network_service.dart';
import '../../domain/entities/login_state.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController(this.ref) : super(const LoginState());
  final Ref ref;

  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  /// Orquesta el proceso de login.
  Future<bool?> login(String username, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // 1. Obtiene la información del dispositivo y la red
      final futures = await Future.wait([
        DeviceInfoService.getDeviceInfo(),
        NetworkService.getLocalIpAddress(),
      ]);
      final deviceInfo = futures[0] as Map<String, dynamic>;
      final ipAddress = futures[1] as String?;

      final browserInfo = DeviceInfoService.generateBrowserInfo(deviceInfo);
      final operatingSystem = DeviceInfoService.generateOperatingSystem(
        deviceInfo,
      );

      // 2. Crea el objeto de la solicitud
      final request = RequestUserAuth(
        userName: username.trim(),
        password: password,
        browserInfo: browserInfo,
        ipAddress: ipAddress,
        operatingSystem: operatingSystem,
      );

      // 3. Llama al notificador de autenticación
      final notifier = ref.read(authNotifierProvider.notifier);
      final session = await notifier.login(request);

      state = state.copyWith(isLoading: false);

      // 4. Devuelve el resultado a la UI para la navegación
      return session.user.isAffiliate;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return null;
    }
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>(
      (ref) => LoginController(ref),
    );
