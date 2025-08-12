import 'package:flutter/material.dart';
import 'summary_card.dart';

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
    return Row(
      children: [
        Expanded(
          child: SummaryCard(
            icon: Icons.receipt_long,
            title: 'Total Compras',
            value: totalPurchases.toString(),
            color: Colors.blue.shade400,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SummaryCard(
            icon: Icons.account_balance_wallet_outlined,
            title: 'Gasto (últ. 30 días)',
            value: 'CRC ${last30DaysExpense.toStringAsFixed(2)}',
            color: Colors.green.shade400,
          ),
        ),
      ],
    );
  }
}