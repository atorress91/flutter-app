import 'package:my_app/features/dashboard/domain/entities/invoice.dart';

class PurchasesState {
  final bool isLoading;
  final String? error;
  final List<Invoice> invoices;

  const PurchasesState({
    this.isLoading = false,
    this.error,
    this.invoices = const [],
  });

  PurchasesState copyWith({
    bool? isLoading,
    String? error,
    List<Invoice>? invoices,
  }) {
    return PurchasesState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      invoices: invoices ?? this.invoices,
    );
  }
}
