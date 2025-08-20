import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/features/auth/data/providers/auth_providers.dart';
import 'package:my_app/features/auth/presentation/providers/auth_state_provider.dart';
import '../../../../core/data/request/request_user_auth.dart';

import '../../../../core/services/platform/device_info_service.dart';
import '../../../../core/services/platform/network_service.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Caso de Uso para encapsular toda la lógica de negocio del login.
class PerformLoginUseCase {
  final AuthRepository _authRepository;
  final AuthNotifier _authNotifier;

  PerformLoginUseCase(this._authRepository, this._authNotifier);

  /// El único método público, ejecuta la acción.
  Future<User> execute(String username, String password) async {
    // 1. Orquesta la obtención de datos adicionales (info del dispositivo, IP).
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

    // 2. Crea el objeto de la solicitud.
    final request = RequestUserAuth(
      userName: username.trim(),
      password: password,
      browserInfo: browserInfo,
      ipAddress: ipAddress,
      operatingSystem: operatingSystem,
    );

    // 3. Llama al notificador para que actualice el estado de la sesión.
    final session = await _authNotifier.login(request);

    return session.user;
  }
}

// Provider para el Caso de Uso
final performLoginUseCaseProvider = Provider<PerformLoginUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final authNotifier = ref.watch(authNotifierProvider.notifier);
  return PerformLoginUseCase(authRepository, authNotifier);
});
