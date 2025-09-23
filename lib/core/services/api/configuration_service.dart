import 'package:my_app/core/config/environments.dart';
import 'package:my_app/core/data/dtos/withdrawals_wallet_configuration_dto.dart';
import 'package:my_app/core/data/models/api_response.dart';
import 'package:my_app/core/services/api/base_service.dart';

class ConfigurationService extends BaseService {
  ConfigurationService({super.client})
    : super(microservice: Microservice.systemConfiguration);

  Future<ApiResponse<WithdrawalsWalletConfigurationDto?>>
  getWithdrawalsWalletConfiguration() async {
    return get<WithdrawalsWalletConfigurationDto>(
      '/configuration/get_withdrawals_wallet_configuration',
      fromJson: (json) {
        if (json == null) {
          return null;
        }
        if (json is Map<String, dynamic>) {
          return WithdrawalsWalletConfigurationDto.fromJson(json);
        }

        throw Exception('Formato de datos inválido para la configuración');
      },
    );
  }
}
