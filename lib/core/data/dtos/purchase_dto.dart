import 'package:json_annotation/json_annotation.dart';

part 'purchase_dto.g.dart';

@JsonSerializable()
class PurchaseDto {
  @JsonKey(defaultValue: 0)
  final int year;

  @JsonKey(defaultValue: 0)
  final int month;

  @JsonKey(defaultValue: 0)
  final int totalPurchases;

  PurchaseDto({
    required this.year,
    required this.month,
    required this.totalPurchases,
  });

  factory PurchaseDto.fromJson(Map<String, dynamic> json) =>
      _$PurchaseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseDtoToJson(this);
}
