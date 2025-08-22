import 'package:my_app/core/data/mappers/user_mapper.dart';
import 'package:my_app/core/data/request/request_user_auth.dart';
import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/core/services/api/auth_service.dart';
import 'package:my_app/features/auth/domain/entities/user.dart';
import 'package:my_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:my_app/core/data/mappers/error_mapper.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Future<User> login(RequestUserAuth request) async {
    final response = await _authService.login(request);

    if (response.success && response.data != null) {
      return UserMapper.fromDto(response.data!);
    } else {
      throw ErrorMapper.mapApiError(response, context: 'autenticación');
    }
  }

  @override
  Future<void> logout() async {
    return;
  }
}
