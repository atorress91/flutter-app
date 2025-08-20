import 'package:flutter/material.dart';
import 'package:my_app/features/dashboard/domain/entities/transaction.dart';

import 'transaction_card.dart';

class TransactionHistoryList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionHistoryList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const Center(child: Text('No hay movimientos recientes.'));
    }
    return ListView.separated(
      itemCount: transactions.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final tx = transactions[index];
        return TransactionCard(
          transaction: tx,
          onTap: () {
            // TODO: Navegar a detalle
          },
        );
      },
    );
  }
}
