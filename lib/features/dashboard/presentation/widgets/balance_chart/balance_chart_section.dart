import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_app/features/dashboard/presentation/models/balance_chart_view_model.dart';

class _SectionData {
  final Color color;
  final String title;
  final String value;

  _SectionData({required this.color, required this.title, required this.value});
}

_SectionData getSectionData(int index, BalancePoint balance) {
  switch (index) {
    case 0:
      return _SectionData(
        color: const Color(0xFF00F5D4), // Disponible: verde-agua
        title: 'Disponible',
        value: balance.available.toStringAsFixed(2),
      );
    case 1:
      return _SectionData(
        color: const Color(0xFFE53935), // Bloqueado: rojo vibrante
        title: 'Bloqueado',
        value: balance.locked.toStringAsFixed(2),
      );
    case 2:
      return _SectionData(
        color: const Color.fromRGBO(197, 252, 68, 1.0), // Recycoins: lima
        title: 'Recycoins',
        value: balance.recycoins.toStringAsFixed(2),
      );
    default:
      throw Exception('Índice no válido para la sección del gráfico');
  }
}

PieChartSectionData buildChartSection({
  required int index,
  required BalancePoint balance,
  required int touchedIndex,
}) {
  final isTouched = index == touchedIndex;
  final radius = isTouched ? 100.0 : 90.0;
  final color = getSectionData(index, balance).color;
  final valueStr = getSectionData(index, balance).value;
  final parsed = double.tryParse(valueStr) ?? 0.0;
  final value = parsed > 0 ? parsed : 0.001; // mantener visible

  return PieChartSectionData(
    color: color.withOpacity(isTouched ? 1.0 : 0.85),
    value: value,
    title: '', // ocultar títulos en las secciones
    showTitle: false,
    radius: radius,
  );
}
