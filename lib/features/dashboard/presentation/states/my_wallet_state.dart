import 'package:my_app/features/dashboard/domain/entities/transaction.dart';

enum TransactionFilterType { all, credit, debit }

class MyWalletState {
  final bool isLoading;
  final String? error;
  final List<Transaction> transactions;
  final TransactionFilterType filter;

  const MyWalletState({
    this.isLoading = false,
    this.error,
    this.transactions = const [],
    this.filter = TransactionFilterType.all,
  });

  List<Transaction> get filteredTransactions {
    List<Transaction> filtered = transactions;

    if (filter == TransactionFilterType.credit) {
      filtered = transactions.where((t) => t.credit > 0).toList();
    } else if (filter == TransactionFilterType.debit) {
      filtered = transactions.where((t) => t.debit > 0).toList();
    }

    return filtered.take(50).toList();
  }

  MyWalletState copyWith({
    bool? isLoading,
    String? error,
    List<Transaction>? transactions,
    TransactionFilterType? filter,
  }) {
    return MyWalletState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      transactions: transactions ?? this.transactions,
      filter: filter ?? this.filter,
    );
  }
}
