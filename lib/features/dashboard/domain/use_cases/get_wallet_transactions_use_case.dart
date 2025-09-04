import 'package:my_app/features/dashboard/domain/entities/transaction.dart';
import 'package:my_app/features/dashboard/domain/repositories/wallet_repository.dart';

class GetWalletTransactionsUseCase {
  final WalletRepository _walletRepository;

  GetWalletTransactionsUseCase(this._walletRepository);

  Future<List<Transaction>> execute({required int userId}) async {
    return await _walletRepository.getWalletTransactions(userId);
  }
}
