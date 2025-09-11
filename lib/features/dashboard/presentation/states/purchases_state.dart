import 'package:my_app/features/dashboard/domain/entities/purchase.dart';

class PurchasesState {
  final bool isLoading;
  final String? error;
  final List<Purchase> invoices;

  const PurchasesState({
    this.isLoading = false,
    this.error,
    this.invoices = const [],
  });

  PurchasesState copyWith({
    bool? isLoading,
    String? error,
    List<Purchase>? invoices,
  }) {
    return PurchasesState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      invoices: invoices ?? this.invoices,
    );
  }
}
