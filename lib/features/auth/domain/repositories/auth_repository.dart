import '../../../../core/data/request/request_user_auth.dart';
import '../../../../core/data/request/request_user_registration.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(RequestUserAuth request);
  Future<User> register(RequestUserRegistration request);
  Future<void> logout();
}
