import 'package:my_app/core/config/environments.dart';
import 'package:my_app/core/data/dtos/network_info_dto.dart';
import 'package:my_app/core/data/dtos/wallet_dto.dart';

import 'package:my_app/core/data/models/api_response.dart';
import 'package:my_app/core/services/api/base_service.dart';
import 'package:my_app/core/data/dtos/balance_information_dto.dart';

class WalletService extends BaseService {
  WalletService({super.client}) : super(microservice: Microservice.wallet);

  Future<ApiResponse<BalanceInformationDto?>> getBalanceInformationByUserId(
    int userId,
  ) async {
    return get<BalanceInformationDto?>(
      '/wallet/GetBalanceInformationByAffiliateId/$userId',
      fromJson: (json) {
        if (json == null) {
          return null;
        }
        if (json is Map<String, dynamic>) {
          return BalanceInformationDto.fromJson(json);
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

  Future<Future<ApiResponse<List<WalletDto>?>>> getWalletByAffiliateId(int userId) async {
    return get<List<WalletDto>>(
      '/wallet/GetWalletByAffiliateId/$userId',
      fromJson: (json) {
        if (json is List) {
          return json
              .map((e) => WalletDto.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        throw Exception('Invalid data format for wallet');
      },
    );
  }
}
