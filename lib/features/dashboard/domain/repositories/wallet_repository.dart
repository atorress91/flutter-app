import 'package:my_app/features/dashboard/domain/entities/transaction.dart';

abstract class WalletRepository {
  Future<List<Transaction>> getWalletTransactions(int userId);
}
