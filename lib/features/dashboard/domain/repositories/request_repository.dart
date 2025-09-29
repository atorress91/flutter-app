import 'package:my_app/core/data/request/wallet_request.dart';
import 'package:my_app/features/dashboard/domain/entities/payment.dart';

abstract class RequestRepository {
  Future<bool> generateVerificationCode(int userId);
  Future<List<Payment>> getWalletRequestByAffiliateId(int userId);
  Future<bool> createWalletRequest(WalletRequest request);
}
