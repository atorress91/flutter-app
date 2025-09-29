import 'package:my_app/features/dashboard/domain/repositories/request_repository.dart';

class GetWalletRequestUseCase {
  final RequestRepository repository;

  GetWalletRequestUseCase(this.repository);

  Future<bool> execute(int userId) async {
    return repository.getWalletRequestByAffiliateId(userId);
  }
}
