import 'package:json_annotation/json_annotation.dart';

part 'wallet_dto.g.dart';

@JsonSerializable()
class WalletDto {
  final int id;
  final int affiliateId;
  final String? affiliateUserName;
  final String? adminUserName;
  final int userId;
  final double credit;
  final double debit;
  final double? deferred;

  @JsonKey(defaultValue: false)
  final bool status;

  final String? concept;
  final int? support;
  final DateTime date;

  @_IntBoolConverter()
  final bool compression;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  WalletDto({
    required this.id,
    required this.affiliateId,
    this.affiliateUserName,
    this.adminUserName,
    required this.userId,
    required this.credit,
    required this.debit,
    this.deferred,
    required this.status,
    this.concept,
    this.support,
    required this.date,
    required this.compression,
    this.createdAt,
    this.updatedAt,
  });

  factory WalletDto.fromJson(Map<String, dynamic> json) =>
      _$WalletDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WalletDtoToJson(this);
}

class _IntBoolConverter implements JsonConverter<bool, int> {
  const _IntBoolConverter();

  @override
  bool fromJson(int json) => json == 1;

  @override
  int toJson(bool object) => object ? 1 : 0;
}
