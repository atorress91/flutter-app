import 'package:my_app/core/data/models/api_response.dart';
import 'package:my_app/core/errors/exceptions.dart';

class ErrorMapper {
  static Exception mapApiError(ApiResponse response, {String? context}) {
    if (_isAuthenticationError(response)) {
      return AuthException('Las credenciales son incorrectas');
    }

    if (response.statusCode == 403) {
      return AuthException('No tienes permisos para realizar esta acción');
    }

    if (response.statusCode == 400) {
      return ApiException(
        response.message ?? 'Los datos enviados no son válidos',
      );
    }

    if (response.statusCode != null && response.statusCode! >= 500) {
      return ApiException('Error interno del servidor. Intenta más tarde');
    }

    final contextMessage = context != null ? 'Error en $context: ' : '';
    return ApiException(
      '$contextMessage${response.message ?? 'Error desconocido'}',
    );
  }

  static bool _isAuthenticationError(ApiResponse response) {
    if (response.statusCode == 401) return true;

    if (response.message != null) {
      final patterns = [
        'no se encontraron datos de usuario válidos',
        'invalid credentials',
        'unauthorized',
        'authentication failed',
      ];
      final lowerMessage = response.message!.toLowerCase();
      return patterns.any((pattern) => lowerMessage.contains(pattern));
    }

    return false;
  }
}
