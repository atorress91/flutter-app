import 'package:my_app/core/data/request/user_auth_request.dart';
import 'package:my_app/core/data/request/user_registration_request.dart';
import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/core/services/api/auth_service.dart';
import 'package:my_app/features/auth/data/mappers/user_mapper.dart';
import 'package:my_app/features/auth/domain/entities/user.dart';
import 'package:my_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Future<User> login(UserAuthRequest request) async {
    final response = await _authService.login(request);

    if (response.success && response.data != null) {
      return UserMapper.fromDto(response.data!);
    } else {
      throw ApiException(
        response.message ?? 'Error de autenticación desconocido',
      );
    }
  }

  @override
  Future<User> register(UserRegistrationRequest request) async {
    final response = await _authService.register(request);

    if (response.success && response.data != null) {
      return UserMapper.fromDto(response.data!);
    } else {
      throw ApiException(response.message ?? 'Error de registro desconocido');
    }
  }

  @override
  Future<void> logout() async {
    return;
  }

  @override
  Future<bool> sendPasswordResetLink(String email) async {
    final response = await _authService.sendPasswordResetLink(email);

    if (response.success && response.data != null) {
      return response.data!;
    } else {
      throw ApiException(
        response.message ?? 'Error al enviar el link de recuperación',
      );
    }
  }
}
