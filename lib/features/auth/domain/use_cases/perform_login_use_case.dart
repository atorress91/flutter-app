import '../../../../core/data/request/request_user_auth.dart';
import '../../../../core/services/platform/device_info_service.dart';
import '../../../../core/services/platform/network_service.dart';

/// Caso de Uso para encapsular la construcción de la solicitud de login
/// y la orquestación de datos de dispositivo/red. Mantiene Domain libre de Riverpod.
class PerformLoginUseCase {
  PerformLoginUseCase();

  /// Construye la RequestUserAuth necesaria para realizar el login.
  /// La ejecución del login y la actualización de estado de sesión
  /// queda en la capa de presentación (AuthNotifier/Controller).
  Future<RequestUserAuth> execute(String username, String password) async {
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

    // 2. Crea y devuelve el objeto de la solicitud.
    return RequestUserAuth(
      userName: username.trim(),
      password: password,
      browserInfo: browserInfo,
      ipAddress: ipAddress,
      operatingSystem: operatingSystem,
    );
  }
}
