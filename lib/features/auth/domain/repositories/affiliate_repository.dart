import 'package:my_app/features/auth/domain/entities/user.dart';

abstract class AffiliateRepository {
  Future<User> getCurrentUser(int userId);
}
