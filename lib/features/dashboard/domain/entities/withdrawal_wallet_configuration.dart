import 'package:equatable/equatable.dart';

class WithdrawalWalletConfiguration extends Equatable {
  final int minimumAmount;
  final int maximumAmount;
  final int commissionAmount;
  final bool activateInvoiceCancellation;

  const WithdrawalWalletConfiguration({
    required this.minimumAmount,
    required this.maximumAmount,
    required this.commissionAmount,
    required this.activateInvoiceCancellation,
  });

  @override
  List<Object?> get props => [
    minimumAmount,
    maximumAmount,
    commissionAmount,
    activateInvoiceCancellation,
  ];
}
