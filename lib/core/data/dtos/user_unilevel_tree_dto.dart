import 'package:json_annotation/json_annotation.dart';

part 'user_unilevel_tree_dto.g.dart';

@JsonSerializable()
class UserUniLevelTreeDto {
  @JsonKey(name: 'userName', defaultValue: '')
  final String userName;

  @JsonKey(name: 'id', defaultValue: 0)
  final int id;

  @JsonKey(name: 'level', defaultValue: 0)
  final int level;

  @JsonKey(name: 'father', defaultValue: 0)
  final int father;

  @JsonKey(name: 'description', defaultValue: '')
  final String description;

  @JsonKey(name: 'image', defaultValue: '')
  final String image;

  @JsonKey(name: 'byte', defaultValue: 0)
  final int byte;

  @JsonKey(name: 'children', defaultValue: [])
  final List<UserUniLevelTreeDto> children;

  UserUniLevelTreeDto({
    required this.userName,
    required this.id,
    required this.level,
    required this.father,
    required this.description,
    required this.image,
    required this.byte,
    required this.children,
  });

  factory UserUniLevelTreeDto.fromJson(Map<String, dynamic> json) =>
      _$UserUniLevelTreeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserUniLevelTreeDtoToJson(this);
}
