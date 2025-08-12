import 'package:flutter/material.dart';
import '../../domain/entities/purchase.dart';
import 'no_result_widget.dart';
import 'purchase_card.dart';

class PurchasesList extends StatelessWidget {
  final List<Purchase> purchases;

  const PurchasesList({
    super.key,
    required this.purchases,
  });

  @override
  Widget build(BuildContext context) {
    if (purchases.isEmpty) {
      return const NoResultsWidget();
    }

    return Column(
      children: purchases
          .map((purchase) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
        child: PurchaseCard(purchase: purchase),
      ))
          .toList(),
    );
  }
}