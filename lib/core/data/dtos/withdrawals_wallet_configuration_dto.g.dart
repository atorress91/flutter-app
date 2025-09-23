// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawals_wallet_configuration_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawalsWalletConfigurationDto _$WithdrawalsWalletConfigurationDtoFromJson(
  Map<String, dynamic> json,
) => WithdrawalsWalletConfigurationDto(
  minimumAmount: (json['minimum_amount'] as num?)?.toInt() ?? 0,
  maximumAmount: (json['maximum_amount'] as num?)?.toInt() ?? 0,
  commissionAmount: (json['commission_amount'] as num?)?.toInt() ?? 0,
  activateInvoiceCancellation:
      json['activate_invoice_cancellation'] as bool? ?? false,
);

Map<String, dynamic> _$WithdrawalsWalletConfigurationDtoToJson(
  WithdrawalsWalletConfigurationDto instance,
) => <String, dynamic>{
  'minimum_amount': instance.minimumAmount,
  'maximum_amount': instance.maximumAmount,
  'commission_amount': instance.commissionAmount,
  'activate_invoice_cancellation': instance.activateInvoiceCancellation,
};
