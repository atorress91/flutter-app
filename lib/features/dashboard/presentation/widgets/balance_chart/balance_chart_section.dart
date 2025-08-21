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
        color: const Color(0xFF42A5F5),
        title: 'Disponible',
        value: balance.available.toStringAsFixed(2),
      );
    case 1:
      return _SectionData(
        color: const Color(0xFFEF5350),
        title: 'Bloqueado',
        value: balance.locked.toStringAsFixed(2),
      );
    case 2:
      return _SectionData(
        color: const Color.fromRGBO(197, 252, 68, 1.0),
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
  final fontSize = isTouched ? 20.0 : 16.0;
  final radius = isTouched ? 100.0 : 90.0;
  final color = getSectionData(index, balance).color;
  final value = getSectionData(index, balance).value;

  // No mostrar la sección si el valor es cero o negativo
  if (double.tryParse(value)! <= 0) {
    return PieChartSectionData(
      value: 0,
      showTitle: false,
      color: Colors.transparent,
    );
  }

  return PieChartSectionData(
    color: color,
    value: double.parse(value),
    title: value,
    radius: radius,
    titleStyle: TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      shadows: const [Shadow(color: Colors.black26, blurRadius: 2)],
    ),
  );
}
