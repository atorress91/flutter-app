import 'package:my_app/features/dashboard/domain/entities/network_purchase.dart';

class NetworkPurchaseState {
  final bool isLoading;
  final List<NetworkPurchase> purchases;
  final String? error;

  const NetworkPurchaseState({
    this.isLoading = false,
    this.purchases = const [],
    this.error,
  });

  NetworkPurchaseState copyWith({
    bool? isLoading,
    List<NetworkPurchase>? purchases,
    String? error,
  }) {
    return NetworkPurchaseState(
      isLoading: isLoading ?? this.isLoading,
      purchases: purchases ?? this.purchases,
      error: error ?? this.error,
    );
  }
}
