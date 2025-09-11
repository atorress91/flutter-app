import 'package:my_app/features/auth/domain/entities/user.dart';
import 'package:my_app/features/auth/domain/repositories/affiliate_repository.dart';

class GetCurrentUserUseCase {
  final AffiliateRepository _affiliateRepository;

  GetCurrentUserUseCase(this._affiliateRepository);

  Future<User?> execute(User currentUser) async {
    try {
      return await _affiliateRepository.getCurrentUser(currentUser.id);
    } catch (e) {
      return null;
    }
  }
}
