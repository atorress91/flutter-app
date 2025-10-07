import '../repositories/auth_repository.dart';

/// Caso de Uso para enviar el link de recuperación de contraseña
class SendPasswordResetLinkUseCase {
  final AuthRepository _authRepository;

  SendPasswordResetLinkUseCase(this._authRepository);

  /// Ejecuta el envío del link de recuperación al email proporcionado
  Future<bool> execute(String email) async {
    return await _authRepository.sendPasswordResetLink(email);
  }
}

