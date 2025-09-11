import 'package:flutter/material.dart';
import 'package:my_app/features/dashboard/domain/entities/purchase.dart';

class PurchasesUtils {
  static List<Purchase> filterInvoices({
    required List<Purchase> invoices,
    String query = '',
    DateTimeRange? dateRange,
  }) {
    return invoices.where((invoice) {
      final purchase = invoice;
      final matchesQuery = query.isEmpty || purchase.matchesQuery(query);
      final matchesDateRange = purchase.isWithinDateRange(dateRange);
      return matchesQuery && matchesDateRange;
    }).toList();
  }

  static double calculateLast30DaysExpense(List<Purchase> invoices) {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    return invoices
        .where((i) => i.createdAt.isAfter(thirtyDaysAgo))
        .fold(0.0, (sum, item) => sum + item.amount);
  }
}
