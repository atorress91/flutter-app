import '../../../../core/data/request/user_registration_request.dart';
import '../../../../core/services/platform/device_info_service.dart';
import '../../../../core/services/platform/network_service.dart';

/// Caso de Uso para encapsular la construcción de la solicitud de registro
/// y la orquestación de datos de dispositivo/red. Mantiene Domain libre de Riverpod.
class PerformRegistrationUseCase {
  PerformRegistrationUseCase();

  /// Construye la RequestUserRegistration necesaria para realizar el registro.
  /// La ejecución del registro y la actualización de estado de sesión
  /// queda en la capa de presentación (AuthNotifier/Controller).
  Future<UserRegistrationRequest> execute({
    required String userName,
    required String password,
    required String confirmPassword,
    required String firstName,
    required String lastName,
    required String country,
    required String phoneNumber,
    required String email,
    required bool acceptedTerms,
    String? referralUserName,
  }) async {
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
    return UserRegistrationRequest(
      userName: userName.trim(),
      password: password,
      confirmPassword: confirmPassword,
      firstName: firstName.trim(),
      lastName: lastName.trim(),
      country: country,
      phoneNumber: phoneNumber.trim(),
      email: email.trim().toLowerCase(),
      acceptedTerms: acceptedTerms,
      referralUserName: referralUserName?.trim(),
      browserInfo: browserInfo,
      ipAddress: ipAddress,
      operatingSystem: operatingSystem,
    );
  }
}