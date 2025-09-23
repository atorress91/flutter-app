import 'package:my_app/features/dashboard/domain/entities/withdrawal_wallet_configuration.dart';
import 'package:my_app/features/dashboard/domain/repositories/configuration_repository.dart';

class GetWithdrawalWalletConfigurationUseCase {
  final ConfigurationRepository configurationRepository;

  GetWithdrawalWalletConfigurationUseCase(this.configurationRepository);

  Future<WithdrawalWalletConfiguration> execute() {
    return configurationRepository.getWithdrawalWalletConfiguration();
  }
}
