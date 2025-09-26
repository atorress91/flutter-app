import 'package:my_app/core/data/request/wallet_request.dart';

abstract class RequestRepository {
  Future<bool> generateVerificationCode(int userId);
  Future<bool> getWalletRequestByAffiliateId(int userId);
  Future<bool> createWalletRequest(WalletRequest request);
}
