import '../../../../core/data/request/request_user_auth.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(RequestUserAuth request);
  Future<void> logout();
}
