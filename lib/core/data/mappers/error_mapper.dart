import 'package:my_app/core/errors/exceptions.dart';

class ErrorMapper {
  ErrorMapper._();

  static String getMessage(Object error) {
    if (error is ApiException) {
      final message = error.message.toLowerCase();

      // if (message.contains('user_not_found') ||
      //     message.contains('invalid_credentials') ||
      //     message.contains('unauthorized') ||
      //     message.contains('invalid') ||
      //     message.contains('incorrect') ||
      //     message.contains('wrong') ||
      //     message.contains('authentication') ||
      //     message.contains('credenciales') ||
      //     message.contains('usuario') ||
      //     message.contains('contraseña') ||
      //     message.contains('password')) {
      return message;
    }

    return 'Ocurrió un error inesperado al comunicarse con el servidor.';
  }
}
