import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/core/services/api/affiliate_service.dart';
import 'package:my_app/core/services/api/wallet_request_service.dart';
import 'package:my_app/features/dashboard/domain/repositories/request_repository.dart';

class RequestRepositoryImpl implements RequestRepository {
  final WalletRequestService _walletRequestService;
  final AffiliateService _affiliateService;

  RequestRepositoryImpl(this._walletRequestService, this._affiliateService);

  @override
  Future<bool> generateCodeVerification(int userId) async {
    final response = await _affiliateService.generateVerificationCode(userId, false,);

    if (response.success && response.data != null) {
      return response.data!;
    } else {
      throw ApiException(
        response.message ?? 'Error al generar el código de verificación',
      );
    }
  }

  @override
  Future<bool> getWalletRequestByAffiliateId(int userId) async {
    final response = await _walletRequestService.getWalletRequestByAffiliateId(userId);

    if (response.success && response.data != null) {
      return response.data!.isNotEmpty;
    } else {
      throw ApiException(
        response.message ?? 'Error al obtener las solicitudes de retiro',
      );
    }
  }
}
