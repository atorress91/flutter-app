import 'package:json_annotation/json_annotation.dart';

part 'invoice_detail_dto.g.dart';

@JsonSerializable()
class InvoiceDetailDto {
  @JsonKey(defaultValue: 0)
  final int id;

  @JsonKey(defaultValue: 0)
  final int invoiceId;

  @JsonKey(defaultValue: 0)
  final int productId;

  @JsonKey(defaultValue: 0)
  final int paymentGroupId;

  @JsonKey(defaultValue: false)
  final bool accumMinPurchase;

  final String? productName;

  @JsonKey(defaultValue: 0.0)
  final double productPrice;

  @JsonKey(defaultValue: 0.0)
  final double productPriceBtc;

  final double? productIva;

  @JsonKey(defaultValue: 0)
  final int productQuantity;

  final double? productCommissionable;

  @JsonKey(defaultValue: 0.0)
  final double binaryPoints;

  final int? productPoints;

  @JsonKey(defaultValue: 0.0)
  final double productDiscount;

  final DateTime? date;

  @JsonKey(defaultValue: 0)
  final int combinationId;

  @JsonKey(defaultValue: false)
  final bool productPack;

  final double? baseAmount;
  final double? dailyPercentage;
  final int? waitingDays;

  @JsonKey(defaultValue: 0)
  final int daysToPayQuantity;

  @JsonKey(defaultValue: false)
  final bool productStart;

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  InvoiceDetailDto({
    required this.id,
    required this.invoiceId,
    required this.productId,
    required this.paymentGroupId,
    required this.accumMinPurchase,
    this.productName,
    required this.productPrice,
    required this.productPriceBtc,
    this.productIva,
    required this.productQuantity,
    this.productCommissionable,
    required this.binaryPoints,
    this.productPoints,
    required this.productDiscount,
    this.date,
    required this.combinationId,
    required this.productPack,
    this.baseAmount,
    this.dailyPercentage,
    this.waitingDays,
    required this.daysToPayQuantity,
    required this.productStart,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory InvoiceDetailDto.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceDetailDtoToJson(this);
}
