import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'purchase_status.dart';

class Purchase extends Equatable {
  final String invoiceNo;
  final DateTime date;
  final String model;
  final String details;
  final double amount;
  final PurchaseStatus status;

  const Purchase({
    required this.invoiceNo,
    required this.date,
    required this.model,
    required this.details,
    required this.amount,
    required this.status,
  });

  @override
  List<Object?> get props => [
    invoiceNo,
    date,
    model,
    details,
    amount,
    status
  ];

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
