import 'package:my_app/features/dashboard/domain/entities/transaction.dart';

class MyWalletState {
  final bool isLoading;
  final String? error;
  final List<Transaction> transactions;

  const MyWalletState({
    this.isLoading = false,
    this.error,
    this.transactions = const [],
  });

  MyWalletState copyWith({
    bool? isLoading,
    String? error,
    List<Transaction>? transactions,
  }) {
    return MyWalletState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      transactions: transactions ?? this.transactions,
    );
  }
}
