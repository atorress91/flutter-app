import 'package:my_app/features/dashboard/domain/entities/payment.dart';
import 'package:my_app/features/dashboard/domain/repositories/request_repository.dart';

class GetWalletRequestUseCase {
  final RequestRepository repository;

  GetWalletRequestUseCase(this.repository);

  Future<List<Payment>> execute(int userId) async {
    return repository.getWalletRequestByAffiliateId(userId);
  }
}
