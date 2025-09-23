import 'package:my_app/core/services/api/configuration_service.dart';
import 'package:my_app/features/dashboard/data/mappers/withdrawal_wallet_configuration_mapper.dart';
import 'package:my_app/features/dashboard/domain/entities/withdrawal_wallet_configuration.dart';
import 'package:my_app/features/dashboard/domain/repositories/configuration_repository.dart';

class ConfigurationRepositoryImpl implements ConfigurationRepository {
  final ConfigurationService _configurationService;

  ConfigurationRepositoryImpl(this._configurationService);

  @override
  Future<WithdrawalWalletConfiguration> getWithdrawalWalletConfiguration() async {

    final response = await _configurationService.getWithdrawalsWalletConfiguration();

    if(response.success && response.data != null) {
     return WithdrawalWalletConfigurationMapper.fromDto(response.data!);
    } else {
      throw Exception(response.message ?? 'Error al obtener la configuración de la billetera de retiros');
    }
  }
}
