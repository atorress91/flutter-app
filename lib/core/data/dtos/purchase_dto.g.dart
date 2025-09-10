// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseDto _$PurchaseDtoFromJson(Map<String, dynamic> json) => PurchaseDto(
  year: (json['year'] as num?)?.toInt() ?? 0,
  month: (json['month'] as num?)?.toInt() ?? 0,
  totalPurchases: (json['totalPurchases'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$PurchaseDtoToJson(PurchaseDto instance) =>
    <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'totalPurchases': instance.totalPurchases,
    };
