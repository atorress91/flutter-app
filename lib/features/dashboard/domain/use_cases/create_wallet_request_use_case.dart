import 'package:my_app/core/data/request/wallet_request.dart';
import 'package:my_app/features/dashboard/domain/repositories/request_repository.dart';

class CreateWalletRequestUseCase {
  final RequestRepository repository;

  CreateWalletRequestUseCase(this.repository);

  Future<bool> execute(WalletRequest request) {
    return repository.createWalletRequest(request);
  }
}