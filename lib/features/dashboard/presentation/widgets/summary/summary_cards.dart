import 'package:flutter/material.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import 'package:my_app/core/common/widgets/info_card.dart';

class SummaryCards extends StatelessWidget {
  final int totalPurchases;
  final double last30DaysExpense;

  const SummaryCards({
    super.key,
    required this.totalPurchases,
    required this.last30DaysExpense,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    
    return SizedBox(
      height: 90,
      child: Row(
        children: [
          Expanded(
            child: InfoCard(
              icon: Icons.receipt_long,
              title: l10n.purchasesTotalPurchases,
              value: totalPurchases.toString(),
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: InfoCard(
              icon: Icons.account_balance_wallet_outlined,
              title: l10n.purchasesExpenseLast30Days,
              value: 'CRC ${last30DaysExpense.toStringAsFixed(2)}',
              color: colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}