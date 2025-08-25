import 'package:my_app/core/config/environments.dart';
import 'package:my_app/core/data/dtos/network_info_dto.dart';

import 'package:my_app/core/data/models/api_response.dart';
import 'package:my_app/core/services/api/base_service.dart';
import 'package:my_app/features/dashboard/domain/entities/balance_information.dart';
import 'package:my_app/core/data/dtos/balance_information_dto.dart';
import 'package:my_app/core/data/mappers/balance_information_mapper.dart';

class WalletService extends BaseService {
  WalletService({super.client}) : super(microservice: Microservice.wallet);

  Future<ApiResponse<BalanceInformation?>> getBalanceInformationByUserId(
    int userId,
  ) async {
    return get<BalanceInformation?>(
      '/wallet/GetBalanceInformationByAffiliateId/$userId',
      fromJson: (json) {
        if (json == null) {
          return null;
        }
        if (json is Map<String, dynamic>) {
          final balanceDto = BalanceInformationDto.fromJson(json);
          return BalanceInformationMapper.fromDto(balanceDto);
        }

        throw Exception(
          'Formato de datos inválido para la información del balance',
        );
      },
    );
  }

  Future<ApiResponse<NetworkInfoDto?>> getPurchasesInMyNetwork(
    int userId,
  ) async {
    return get<NetworkInfoDto?>(
      '/wallet/getPurchasesMadeInMyNetwork/$userId',
      fromJson: (json) {
        if (json is Map<String, dynamic>) {
          return NetworkInfoDto.fromJson(json);
        }
        throw Exception('Invalid data format for purchases');
      },
    );
  }
}
