import 'package:my_app/core/data/request/wallet_request.dart';
import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/core/services/api/affiliate_service.dart';
import 'package:my_app/core/services/api/wallet_request_service.dart';
import 'package:my_app/features/dashboard/data/mappers/request_mapper.dart';
import 'package:my_app/features/dashboard/domain/entities/payment.dart';
import 'package:my_app/features/dashboard/domain/repositories/request_repository.dart';

class RequestRepositoryImpl implements RequestRepository {
  final WalletRequestService _walletRequestService;
  final AffiliateService _affiliateService;

  RequestRepositoryImpl(this._walletRequestService, this._affiliateService);

  @override
  Future<bool> generateVerificationCode(int userId) async {
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
  Future<List<Payment>> getWalletRequestByAffiliateId(int userId) async {
    final response = await _walletRequestService.getWalletRequestByAffiliateId(userId);

    if (response.success && response.data != null) {
      return response.data!.map((dto) => RequestMapper.fromDto(dto)).toList();
    } else {
      throw ApiException(
        response.message ?? 'Error al obtener las solicitudes de retiro',
      );
    }
  }

  @override
  Future<bool> createWalletRequest(WalletRequest request) async {
    final response = await _walletRequestService.createWalletRequest(request);

    if (response.success && response.data != null) {
      return true;
    } else {
      throw ApiException(
        response.message ?? 'Error al crear la solicitud de retiro',
      );
    }
  }
}
