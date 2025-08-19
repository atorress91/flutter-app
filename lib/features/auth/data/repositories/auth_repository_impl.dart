import '../../../../core/data/request/request_user_auth.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/services/api/auth_service.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Future<User> login(RequestUserAuth request) async {
    final response = await _authService.login(request);

    if (response.success) {
      return response.data!;
    } else {
      throw ApiException(response.message ?? 'Error de autenticación');
    }
  }

  @override
  Future<void> logout() async {
    return;
  }
}
