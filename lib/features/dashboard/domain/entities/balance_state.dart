import 'package:my_app/features/dashboard/domain/entities/balance_information.dart';

class BalanceState {
  final bool isLoading;
  final BalanceInformation? balance;
  final String? error;

  const BalanceState({this.isLoading = false, this.balance, this.error});

  BalanceState copyWith({
    bool? isLoading,
    BalanceInformation? balance,
    String? error,
  }) {
    return BalanceState(
      isLoading: isLoading ?? this.isLoading,
      balance: balance ?? this.balance,
      error: error ?? this.error,
    );
  }
}
