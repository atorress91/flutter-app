import 'package:flutter/material.dart';

import '../../features/dashboard/domain/entities/purchase.dart';

class PurchasesUtils {
  static List<Purchase> filterPurchases({
    required List<Purchase> purchases,
    String query = '',
    DateTimeRange? dateRange,
  }) {
    return purchases.where((purchase) {
      final matchesQuery = query.isEmpty || purchase.matchesQuery(query);
      final matchesDateRange = purchase.isWithinDateRange(dateRange);
      return matchesQuery && matchesDateRange;
    }).toList();
  }

  static double calculateLast30DaysExpense(List<Purchase> purchases) {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    return purchases
        .where((p) => p.fecha.isAfter(thirtyDaysAgo))
        .fold(0.0, (sum, item) => sum + item.monto);
  }
}