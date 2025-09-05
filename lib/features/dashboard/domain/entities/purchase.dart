import 'package:flutter/material.dart';
import 'package:my_app/features/dashboard/data/mappers/invoice_mapper.dart';
import 'package:my_app/features/dashboard/domain/entities/invoice.dart';
import 'purchase_status.dart';

class Purchase {
  final String invoiceNo;
  final DateTime date;
  final String model;
  final String details;
  final double amount;
  final PurchaseStatus status;

  Purchase({
    required this.invoiceNo,
    required this.date,
    required this.model,
    required this.details,
    required this.amount,
    required this.status,
  });

  factory Purchase.fromInvoice(Invoice invoice) {
    return InvoiceMapper.toPurchase(invoice);
  }

  bool matchesQuery(String query) {
    final q = query.toLowerCase();
    return invoiceNo.toLowerCase().contains(q) ||
        model.toLowerCase().contains(q) ||
        details.toLowerCase().contains(q);
  }

  bool isWithinDateRange(DateTimeRange? dateRange) {
    if (dateRange == null) return true;

    final start = DateUtils.dateOnly(dateRange.start);
    final end = DateUtils.dateOnly(dateRange.end);
    final purchaseDate = DateUtils.dateOnly(date);

    return !purchaseDate.isBefore(start) && !purchaseDate.isAfter(end);
  }
}