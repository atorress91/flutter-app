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

  factory BalanceInformation.fromJson(Map<String, dynamic> json) {
    return BalanceInformation(
      reverseBalance: (json['reverse_balance'] ?? 0).toDouble(),
      totalAcquisitions: (json['total_acquisitions'] ?? 0).toDouble(),
      availableBalance: (json['available_balance'] ?? 0).toDouble(),
      totalCommissionsPaid: (json['total_commissions_paid'] ?? 0).toDouble(),
      serviceBalance: (json['service_balance'] ?? 0).toDouble(),
      bonusAmount: (json['bonus_amount'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reverse_balance': reverseBalance,
      'total_acquisitions': totalAcquisitions,
      'available_balance': availableBalance,
      'total_commissions_paid': totalCommissionsPaid,
      'service_balance': serviceBalance,
      'bonus_amount': bonusAmount,
    };
  }
}
