// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_information_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceInformationDto _$BalanceInformationDtoFromJson(
  Map<String, dynamic> json,
) => BalanceInformationDto(
  reverseBalance: (json['reverseBalance'] as num?)?.toDouble() ?? 0,
  totalAcquisitions: (json['totalAcquisitions'] as num?)?.toDouble() ?? 0,
  availableBalance: (json['availableBalance'] as num?)?.toDouble() ?? 0,
  totalCommissionsPaid: (json['totalCommissionsPaid'] as num?)?.toDouble() ?? 0,
  serviceBalance: (json['serviceBalance'] as num?)?.toDouble() ?? 0,
  bonusAmount: (json['bonusAmount'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$BalanceInformationDtoToJson(
  BalanceInformationDto instance,
) => <String, dynamic>{
  'reverseBalance': instance.reverseBalance,
  'totalAcquisitions': instance.totalAcquisitions,
  'availableBalance': instance.availableBalance,
  'totalCommissionsPaid': instance.totalCommissionsPaid,
  'serviceBalance': instance.serviceBalance,
  'bonusAmount': instance.bonusAmount,
};
