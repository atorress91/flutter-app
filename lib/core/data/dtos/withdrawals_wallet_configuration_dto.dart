import 'package:json_annotation/json_annotation.dart';

part 'withdrawals_wallet_configuration_dto.g.dart';

@JsonSerializable()
class WithdrawalsWalletConfigurationDto {
  @JsonKey(name: 'minimum_amount', defaultValue: 0)
  final int minimumAmount;

  @JsonKey(name: 'maximum_amount', defaultValue: 0)
  final int maximumAmount;

  @JsonKey(name: 'commission_amount', defaultValue: 0)
  final int commissionAmount;

  @JsonKey(name: 'activate_invoice_cancellation', defaultValue: false)
  final bool activateInvoiceCancellation;

  WithdrawalsWalletConfigurationDto({
    required this.minimumAmount,
    required this.maximumAmount,
    required this.commissionAmount,
    required this.activateInvoiceCancellation,
  });

  factory WithdrawalsWalletConfigurationDto.fromJson(
    Map<String, dynamic> json,
  ) => _$WithdrawalsWalletConfigurationDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$WithdrawalsWalletConfigurationDtoToJson(this);
}
