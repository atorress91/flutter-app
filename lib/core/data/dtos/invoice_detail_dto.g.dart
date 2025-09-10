// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceDetailDto _$InvoiceDetailDtoFromJson(
  Map<String, dynamic> json,
) => InvoiceDetailDto(
  id: (json['id'] as num?)?.toInt() ?? 0,
  invoiceId: (json['invoiceId'] as num?)?.toInt() ?? 0,
  productId: (json['productId'] as num?)?.toInt() ?? 0,
  paymentGroupId: (json['paymentGroupId'] as num?)?.toInt() ?? 0,
  accumMinPurchase: json['accumMinPurchase'] as bool? ?? false,
  productName: json['productName'] as String?,
  productPrice: (json['productPrice'] as num?)?.toDouble() ?? 0.0,
  productPriceBtc: (json['productPriceBtc'] as num?)?.toDouble() ?? 0.0,
  productIva: (json['productIva'] as num?)?.toDouble(),
  productQuantity: (json['productQuantity'] as num?)?.toInt() ?? 0,
  productCommissionable: (json['productCommissionable'] as num?)?.toDouble(),
  binaryPoints: (json['binaryPoints'] as num?)?.toDouble() ?? 0.0,
  productPoints: (json['productPoints'] as num?)?.toInt(),
  productDiscount: (json['productDiscount'] as num?)?.toDouble() ?? 0.0,
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  combinationId: (json['combinationId'] as num?)?.toInt() ?? 0,
  productPack: json['productPack'] as bool? ?? false,
  baseAmount: (json['baseAmount'] as num?)?.toDouble(),
  dailyPercentage: (json['dailyPercentage'] as num?)?.toDouble(),
  waitingDays: (json['waitingDays'] as num?)?.toInt(),
  daysToPayQuantity: (json['daysToPayQuantity'] as num?)?.toInt() ?? 0,
  productStart: json['productStart'] as bool? ?? false,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  deletedAt: json['deletedAt'] == null
      ? null
      : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$InvoiceDetailDtoToJson(InvoiceDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoiceId': instance.invoiceId,
      'productId': instance.productId,
      'paymentGroupId': instance.paymentGroupId,
      'accumMinPurchase': instance.accumMinPurchase,
      'productName': instance.productName,
      'productPrice': instance.productPrice,
      'productPriceBtc': instance.productPriceBtc,
      'productIva': instance.productIva,
      'productQuantity': instance.productQuantity,
      'productCommissionable': instance.productCommissionable,
      'binaryPoints': instance.binaryPoints,
      'productPoints': instance.productPoints,
      'productDiscount': instance.productDiscount,
      'date': instance.date?.toIso8601String(),
      'combinationId': instance.combinationId,
      'productPack': instance.productPack,
      'baseAmount': instance.baseAmount,
      'dailyPercentage': instance.dailyPercentage,
      'waitingDays': instance.waitingDays,
      'daysToPayQuantity': instance.daysToPayQuantity,
      'productStart': instance.productStart,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };
