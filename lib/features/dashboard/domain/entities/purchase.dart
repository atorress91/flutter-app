import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_app/features/dashboard/domain/entities/invoice_detail.dart';
import 'purchase_status.dart';

class Purchase extends Equatable {
  final String invoiceNo;
  final DateTime createdAt;
  final List<InvoiceDetail> details;
  final double amount;
  final PurchaseStatus status;
  final String paymentMethod;

  const Purchase({
    required this.invoiceNo,
    required this.createdAt,
    required this.details,
    required this.amount,
    required this.status,
    required this.paymentMethod,
  });

  @override
  List<Object?> get props => [invoiceNo, createdAt, details, amount, status, paymentMethod];

  bool matchesQuery(String query) {
    final q = query.toLowerCase();
    return invoiceNo.toLowerCase().contains(q) ||
        details.any((detail) => detail.productName.toLowerCase().contains(q));
  }

  bool isWithinDateRange(DateTimeRange? dateRange) {
    if (dateRange == null) return true;

    final start = DateUtils.dateOnly(dateRange.start);
    final end = DateUtils.dateOnly(dateRange.end);
    final purchaseDate = DateUtils.dateOnly(createdAt);

    return !purchaseDate.isBefore(start) && !purchaseDate.isAfter(end);
  }
}
