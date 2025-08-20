class BalanceInformationDto {
  final double reverseBalance;
  final double totalAcquisitions;
  final double availableBalance;
  final double totalCommissionsPaid;
  final double serviceBalance;
  final double bonusAmount;

  BalanceInformationDto({
    required this.reverseBalance,
    required this.totalAcquisitions,
    required this.availableBalance,
    required this.totalCommissionsPaid,
    required this.serviceBalance,
    required this.bonusAmount,
  });

  factory BalanceInformationDto.fromJson(Map<String, dynamic> json) {
    return BalanceInformationDto(
      reverseBalance: (json['reverseBalance'] ?? 0).toDouble(),
      totalAcquisitions: (json['totalAcquisitions'] ?? 0).toDouble(),
      availableBalance: (json['availableBalance'] ?? 0).toDouble(),
      totalCommissionsPaid: (json['totalCommissions_paid'] ?? 0).toDouble(),
      serviceBalance: (json['serviceBalance'] ?? 0).toDouble(),
      bonusAmount: (json['bonusAmount'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'reverse_balance': reverseBalance,
    'total_acquisitions': totalAcquisitions,
    'available_balance': availableBalance,
    'total_commissions_paid': totalCommissionsPaid,
    'service_balance': serviceBalance,
    'bonus_amount': bonusAmount,
  };
}
