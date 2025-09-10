// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_information_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceInformationDto _$BalanceInformationDtoFromJson(
  Map<String, dynamic> json,
) => BalanceInformationDto(
  reverseBalance: (json['reverse_balance'] as num?)?.toDouble() ?? 0,
  totalAcquisitions: (json['total_acquisitions'] as num?)?.toDouble() ?? 0,
  availableBalance: (json['available_balance'] as num?)?.toDouble() ?? 0,
  totalCommissionsPaid:
      (json['total_commissions_paid'] as num?)?.toDouble() ?? 0,
  serviceBalance: (json['service_balance'] as num?)?.toDouble() ?? 0,
  bonusAmount: (json['bonus_amount'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$BalanceInformationDtoToJson(
  BalanceInformationDto instance,
) => <String, dynamic>{
  'reverse_balance': instance.reverseBalance,
  'total_acquisitions': instance.totalAcquisitions,
  'available_balance': instance.availableBalance,
  'total_commissions_paid': instance.totalCommissionsPaid,
  'service_balance': instance.serviceBalance,
  'bonus_amount': instance.bonusAmount,
};
