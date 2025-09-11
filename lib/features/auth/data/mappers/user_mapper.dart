import 'package:my_app/core/data/dtos/users_affiliates_dto.dart';
import 'package:my_app/features/auth/domain/entities/user.dart';

class UserMapper {
  static User fromDto(UsersAffiliatesDto dto) {
    return User(
      id: dto.id,
      userName: dto.userName,
      email: dto.email,
      fullName: (dto.name != null && dto.lastName != null) ? '${dto.name} ${dto.lastName}' : dto.name,
      imageUrl: dto.imageProfileUrl,
      isActive: dto.status,
      createdAt: dto.createdAt,
      isAffiliate: dto.isAffiliate == 1,
    );
  }
}
