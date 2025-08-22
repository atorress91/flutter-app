import 'package:my_app/core/config/environments.dart';
import 'package:my_app/core/data/dtos/purchase_dto.dart';
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
    return get<BalanceInformation>(
      '/wallet/GetBalanceInformationByAffiliateId/$userId',
      fromJson: (json) {
        if (json is Map<String, dynamic>) {
          final balanceDto = BalanceInformationDto.fromJson(json);
          return BalanceInformationMapper.fromDto(balanceDto);
        }
        throw Exception('Invalid data format for balance information');
      },
    );
  }

  Future<ApiResponse<List<PurchaseDto>?>> getPurchasesInMyNetwork(
    int userId,
  ) async {
    return get<List<PurchaseDto>>(
      '/wallet/getPurchasesMadeInMyNetwork/$userId',
      fromJson: (json) {
        if (json is List) {
          return json
              .map((item) => PurchaseMapper.fromDto(PurchaseDto.fromJson(item)))
              .toList();
        }
        throw Exception('Invalid data format for purchases');
      },
    );
  }
}
