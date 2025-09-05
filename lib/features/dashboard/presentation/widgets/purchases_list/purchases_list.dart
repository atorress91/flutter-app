import 'package:flutter/material.dart';
import 'package:my_app/features/dashboard/domain/entities/invoice.dart';
import 'package:my_app/features/dashboard/domain/entities/purchase.dart';
import 'no_result_widget.dart';
import 'purchase_card.dart';

class PurchasesList extends StatelessWidget {
  final List<Invoice> invoices;

  const PurchasesList({super.key, required this.invoices});

  @override
  Widget build(BuildContext context) {
    if (invoices.isEmpty) {
      return const NoResultsWidget();
    }

    return Column(
      children: invoices
          .map(
            (invoice) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: PurchaseCard(purchase: Purchase.fromInvoice(invoice)),
            ),
          )
          .toList(),
    );
  }
}
