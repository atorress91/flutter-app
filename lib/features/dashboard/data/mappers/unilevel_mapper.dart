import 'package:my_app/core/data/dtos/user_unilevel_tree_dto.dart';
import 'package:my_app/features/dashboard/domain/entities/unilevel_tree.dart';

class UniLevelMapper {
  static UniLevelTree fromDto(UserUniLevelTreeDto dto) {
    return UniLevelTree(
      username: dto.userName,
      id: dto.id,
      level: dto.level,
      father: dto.father,
      description: dto.description,
      image: dto.image,
      byte: dto.byte,
      children: dto.children.map((childDto) => fromDto(childDto)).toList(),
    );
  }
}
