import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/core/providers/platform_providers.dart';
import 'package:my_app/core/services/platform/biometric_service.dart';

/// Caso de Uso para el flujo de login biométrico.
class LoginWithBiometricsUseCase {
  final BiometricService _biometricService;

  LoginWithBiometricsUseCase(this._biometricService);

  /// Ejecuta el flujo de login biométrico.
  /// Devuelve las credenciales para que el controlador haga el login.
  Future<Map<String, String>> execute() async {
    // 1. Autentica con el hardware del dispositivo.
    final isAuthenticated = await _biometricService.authenticate(
      reason: 'Autentícate para iniciar sesión',
    );

    if (!isAuthenticated) {
      throw AuthException('Autenticación biométrica cancelada o fallida.');
    }

    // 2. Obtiene las credenciales guardadas
    final credentials = await _biometricService.getCredentials();
    if (credentials == null) {
      throw AuthException(
        'No hay credenciales guardadas. Inicia sesión con tu contraseña primero.',
      );
    }

    return credentials;
  }
}

final loginWithBiometricsUseCaseProvider = Provider<LoginWithBiometricsUseCase>(
  (ref) {
    final biometricService = ref.watch(biometricServiceProvider);
    return LoginWithBiometricsUseCase(biometricService);
  },
);
