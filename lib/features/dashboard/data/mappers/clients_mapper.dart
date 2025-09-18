import 'package:my_app/core/data/dtos/user_unilevel_tree_dto.dart';
import 'package:my_app/features/dashboard/domain/entities/client.dart';

class ClientsMapper {
  static Client fromDto(UserUniLevelTreeDto dto) {
    return Client(
      username: dto.userName,
      id: dto.id,
      level: dto.level,
      father: dto.father,
      description: dto.description,
      image: dto.image,
      byte: dto.byte,
      referrals: dto.children.map((childDto) => fromDto(childDto)).toList(),
    );
  }
}
