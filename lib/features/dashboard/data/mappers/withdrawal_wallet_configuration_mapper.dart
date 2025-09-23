import 'package:my_app/core/data/dtos/withdrawals_wallet_configuration_dto.dart';
import 'package:my_app/features/dashboard/domain/entities/withdrawal_wallet_configuration.dart';

class WithdrawalWalletConfigurationMapper {
  static WithdrawalWalletConfiguration fromDto(WithdrawalsWalletConfigurationDto dto,) {
    return WithdrawalWalletConfiguration(
      minimumAmount: dto.minimumAmount,
      maximumAmount: dto.maximumAmount,
      commissionAmount: dto.commissionAmount,
      activateInvoiceCancellation: dto.activateInvoiceCancellation
    );
  }
}
