import 'package:my_app/features/dashboard/domain/entities/payment.dart';
import 'package:my_app/features/dashboard/domain/entities/withdrawal_wallet_configuration.dart';

class RequestPaymentState {
  final bool isLoading;
  final String? error;
  final WithdrawalWalletConfiguration? configuration;
  final List<Payment> requests;
  final bool hasReachedWithdrawalLimit;

  const RequestPaymentState({
    this.isLoading = false,
    this.error,
    this.configuration = const WithdrawalWalletConfiguration(
      minimumAmount: 0,
      maximumAmount: 0,
      commissionAmount: 0,
      activateInvoiceCancellation: false,
    ),
    this.requests = const [],
    this.hasReachedWithdrawalLimit = false,
  });

  RequestPaymentState copyWith({
    bool? isLoading,
    String? error,
    bool? hasReachedWithdrawalLimit,
    WithdrawalWalletConfiguration? configuration,
    List<Payment>? requests,
  }) {
    return RequestPaymentState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      hasReachedWithdrawalLimit: hasReachedWithdrawalLimit ?? this.hasReachedWithdrawalLimit,
      configuration: configuration ?? this.configuration,
      requests: requests ?? this.requests,
    );
  }
}
