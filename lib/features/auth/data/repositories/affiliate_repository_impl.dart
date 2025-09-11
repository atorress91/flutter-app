import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/core/services/api/affiliate_service.dart';
import 'package:my_app/features/auth/data/mappers/user_mapper.dart';
import 'package:my_app/features/auth/domain/entities/user.dart';
import 'package:my_app/features/auth/domain/repositories/affiliate_repository.dart';

class AffiliateRepositoryImpl implements AffiliateRepository {
  final AffiliateService _affiliateService;

  AffiliateRepositoryImpl(this._affiliateService);

  @override
  Future<User> getCurrentUser(int userId) async {
    final response = await _affiliateService.getAffiliateById(userId);
    if (response.success && response.data != null) {
      return UserMapper.fromDto(response.data!);
    } else {
      throw ApiException(
        response.message ?? 'Error al obtener el usuario actual',
      );
    }
  }
}
