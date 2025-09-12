import 'package:json_annotation/json_annotation.dart';

part 'users_affiliates_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UsersAffiliatesDto {
  final int id;

  @JsonKey(defaultValue: '')
  final String userName;

  @JsonKey(defaultValue: '')
  final String identification;

  @JsonKey(defaultValue: '')
  final String email;

  @JsonKey(defaultValue: 0)
  final int isAffiliate;

  @_IntBoolConverter()
  final bool status;

  final String? name;
  final String? lastName;
  final String? imageProfileUrl;
  final DateTime createdAt;

  @JsonKey(name:'birthday')
  final DateTime? birthDay;

  final String? address;
  final String? phone;
  final String? beneficiaryName;
  final String? beneficiaryEmail;
  final String? beneficiaryPhone;

  UsersAffiliatesDto({
    required this.id,
    required this.userName,
    required this.identification,
    required this.email,
    required this.isAffiliate,
    required this.status,
    this.name,
    this.lastName,
    this.imageProfileUrl,
    required this.createdAt,
    this.birthDay,
    this.address,
    this.phone,
    this.beneficiaryName,
    this.beneficiaryEmail,
    this.beneficiaryPhone
  });

  factory UsersAffiliatesDto.fromJson(Map<String, dynamic> json) =>
      _$UsersAffiliatesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UsersAffiliatesDtoToJson(this);
}

class _IntBoolConverter implements JsonConverter<bool, int> {
  const _IntBoolConverter();

  @override
  bool fromJson(int json) => json == 1;

  @override
  int toJson(bool object) => object ? 1 : 0;
}