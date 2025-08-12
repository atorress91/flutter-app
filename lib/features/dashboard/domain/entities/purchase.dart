import 'package:flutter/material.dart';

import 'purchase_status.dart';

class Purchase {
  final String noFa;
  final DateTime fecha;
  final String modelo;
  final String detalle;
  final double monto;
  final PurchaseStatus status;

  Purchase({
    required this.noFa,
    required this.fecha,
    required this.modelo,
    required this.detalle,
    required this.monto,
    required this.status,
  });

  bool matchesQuery(String query) {
    final q = query.toLowerCase();
    return noFa.toLowerCase().contains(q) ||
        modelo.toLowerCase().contains(q) ||
        detalle.toLowerCase().contains(q);
  }

  bool isWithinDateRange(DateTimeRange? dateRange) {
    if (dateRange == null) return true;

    final start = DateUtils.dateOnly(dateRange.start);
    final end = DateUtils.dateOnly(dateRange.end);
    final purchaseDate = DateUtils.dateOnly(fecha);

    return !purchaseDate.isBefore(start) && !purchaseDate.isAfter(end);
  }
}