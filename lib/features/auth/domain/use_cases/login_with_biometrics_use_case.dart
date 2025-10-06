import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/core/providers/platform_providers.dart';
import 'package:my_app/core/services/platform/biometric_service.dart';

/// Caso de Uso para el flujo de login biométrico.
class LoginWithBiometricsUseCase {
  final BiometricService _biometricService;

  // Se elimina la dependencia del ProviderContainer
  LoginWithBiometricsUseCase(this._biometricService);

  /// Ejecuta el flujo de login biométrico.
  /// Devuelve la ruta a la que se debe navegar.
  Future<String> execute() async {
    // 1. Autentica con el hardware del dispositivo.
    final isAuthenticated = await _biometricService.authenticate(
      reason: 'Autentícate para iniciar sesión',
    );

    if (!isAuthenticated) {
      throw AuthException('Autenticación biométrica cancelada o fallida.');
    }

    // 2. Obtiene el rol del último inicio de sesión exitoso.
    final isAffiliate = await _biometricService.getLastIsAffiliate();
    if (isAffiliate == null) {
      throw AuthException(
        'No hay sesión guardada para usar la huella. Inicia sesión con tu contraseña primero.',
      );
    }

    // 3. Devuelve la ruta de navegación correcta.
    return isAffiliate ? '/dashboard' : '/admin/dashboard';
  }
}

final loginWithBiometricsUseCaseProvider = Provider<LoginWithBiometricsUseCase>(
  (ref) {
    final biometricService = ref.watch(biometricServiceProvider);
    return LoginWithBiometricsUseCase(biometricService);
  },
);
