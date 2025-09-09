import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/features/dashboard/data/providers/account_providers.dart';

class UpdateProfileImageUrlUseCase {
  final AffiliateRepository _affiliateRepository;

  UpdateProfileImageUrlUseCase(this._affiliateRepository);

  Future<void> execute(int userId, String imageUrl) async {
    return await _affiliateRepository.updateProfileImageUrl(userId, imageUrl);
  }
}

