import 'package:my_app/features/dashboard/domain/entities/withdrawal_wallet_configuration.dart';

class RequestPaymentState {
  final bool isLoading;
  final String? error;
  final WithdrawalWalletConfiguration? configuration;

  const RequestPaymentState({
    this.isLoading = false,
    this.error,
    this.configuration = const WithdrawalWalletConfiguration(
      minimumAmount: 0,
      maximumAmount: 0,
      commissionAmount: 0,
      activateInvoiceCancellation: false
    )
  });

  RequestPaymentState copyWith({
    bool? isLoading,
    String? error,
    WithdrawalWalletConfiguration? configuration,
  }) {
    return RequestPaymentState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      configuration: configuration ?? this.configuration,
    );
  }
}
