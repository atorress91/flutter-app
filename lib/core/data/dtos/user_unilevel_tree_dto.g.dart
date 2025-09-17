// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_unilevel_tree_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserUniLevelTreeDto _$UserUniLevelTreeDtoFromJson(Map<String, dynamic> json) =>
    UserUniLevelTreeDto(
      userName: json['userName'] as String? ?? '',
      id: (json['id'] as num?)?.toInt() ?? 0,
      level: (json['level'] as num?)?.toInt() ?? 0,
      father: (json['father'] as num?)?.toInt() ?? 0,
      description: json['description'] as String? ?? '',
      image: json['image'] as String? ?? '',
      byte: (json['byte'] as num?)?.toInt() ?? 0,
      children:
          (json['children'] as List<dynamic>?)
              ?.map(
                (e) => UserUniLevelTreeDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$UserUniLevelTreeDtoToJson(
  UserUniLevelTreeDto instance,
) => <String, dynamic>{
  'userName': instance.userName,
  'id': instance.id,
  'level': instance.level,
  'father': instance.father,
  'description': instance.description,
  'image': instance.image,
  'byte': instance.byte,
  'children': instance.children,
};
