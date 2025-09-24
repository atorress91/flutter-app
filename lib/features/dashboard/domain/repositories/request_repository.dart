abstract class RequestRepository {
  Future<bool> generateCodeVerification(int userId);
  Future<bool> getWalletRequestByAffiliateId(int userId);
}
