import 'package:equatable/equatable.dart';

class BalanceInformation extends Equatable {
  final double reverseBalance;
  final double totalAcquisitions;
  final double availableBalance;
  final double totalCommissionsPaid;
  final double serviceBalance;
  final double bonusAmount;

  const BalanceInformation({
    required this.reverseBalance,
    required this.totalAcquisitions,
    required this.availableBalance,
    required this.totalCommissionsPaid,
    required this.serviceBalance,
    required this.bonusAmount,
  });

  @override
  List<Object?> get props => [
    reverseBalance,
    totalAcquisitions,
    availableBalance,
    totalCommissionsPaid,
    serviceBalance,
    bonusAmount,
  ];
}
