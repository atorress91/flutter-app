import '../../../../core/data/request/user_auth_request.dart';
import '../../../../core/data/request/user_registration_request.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(UserAuthRequest request);
  Future<User> register(UserRegistrationRequest request);
  Future<void> logout();
  Future<bool> sendPasswordResetLink(String email);
}
