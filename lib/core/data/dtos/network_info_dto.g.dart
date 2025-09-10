// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkInfoDto _$NetworkInfoDtoFromJson(Map<String, dynamic> json) =>
    NetworkInfoDto(
      currentYearPurchases:
          (json['currentYearPurchases'] as List<dynamic>?)
              ?.map((e) => PurchaseDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      previousYearPurchases:
          (json['previousYearPurchases'] as List<dynamic>?)
              ?.map((e) => PurchaseDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$NetworkInfoDtoToJson(NetworkInfoDto instance) =>
    <String, dynamic>{
      'currentYearPurchases': instance.currentYearPurchases
          .map((e) => e.toJson())
          .toList(),
      'previousYearPurchases': instance.previousYearPurchases
          .map((e) => e.toJson())
          .toList(),
    };
