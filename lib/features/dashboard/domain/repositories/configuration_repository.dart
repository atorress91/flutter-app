import 'package:my_app/features/dashboard/domain/entities/withdrawal_wallet_configuration.dart';

abstract class ConfigurationRepository {
  Future<WithdrawalWalletConfiguration> getWithdrawalWalletConfiguration();
}
