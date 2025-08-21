class BalancePoint {
  final double available;
  final double locked;
  final double recycoins;

  const BalancePoint({
    required this.available,
    required this.locked,
    this.recycoins = 0.0,
  });

  double get total => available + locked + recycoins;
}

class BalanceChartViewModel {
  final BalancePoint latestBalance;
  final String currencySymbol;

  const BalanceChartViewModel({
    required this.latestBalance,
    this.currencySymbol = '\$',
  });
}
