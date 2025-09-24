abstract class RequestRepository {
  Future<bool> generateVerificationCode(int userId);
  Future<bool> getWalletRequestByAffiliateId(int userId);
}
