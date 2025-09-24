import 'package:my_app/core/config/environments.dart';
import 'package:my_app/core/data/dtos/wallet_request_dto.dart';
import 'package:my_app/core/data/models/api_response.dart';
import 'package:my_app/core/services/api/base_service.dart';

class WalletRequestService extends BaseService {
  WalletRequestService({super.client})
    : super(microservice: Microservice.wallet);

  Future<ApiResponse<List<WalletRequestDto>?>> getWalletRequestByAffiliateId(int userId) async {
    return get<List<WalletRequestDto>?>(
      '/walletRequest/$userId',
      fromJson: (json) {
        if (json is List) {
          return json
              .map((e) => WalletRequestDto.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        throw Exception('Invalid data format for wallet requests');
      },
    );
  }
}
