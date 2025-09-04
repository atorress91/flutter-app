import 'package:my_app/features/dashboard/domain/entities/balance_information.dart';
import 'package:my_app/features/dashboard/domain/entities/network_purchase.dart';

class HomeState{
  final bool isLoading;
  final String? error;
  final BalanceInformation? balance;
  final List<NetworkPurchase> purchases;

  const HomeState({
    this.isLoading = false,
    this.error,
    this.balance,
    this.purchases = const [],
  });

  HomeState copyWith({
    bool? isLoading,
    String? error,
    BalanceInformation? balance,
    List<NetworkPurchase>? purchases,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      balance: balance ?? this.balance,
      purchases: purchases ?? this.purchases,
    );
  }
}
