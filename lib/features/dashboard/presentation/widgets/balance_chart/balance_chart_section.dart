import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_app/core/theme/app_theme.dart';
import 'package:my_app/features/dashboard/presentation/models/balance_chart_view_model.dart';

class SectionData {
  final Color color;
  final String title;
  final String value;

  SectionData({required this.color, required this.title, required this.value});
}

SectionData getSectionData(
  BuildContext context,
  int index,
  BalancePoint balance,
) {
  final theme = Theme.of(context);
  final isDarkMode = theme.brightness == Brightness.dark;

  switch (index) {
    case 0: // Disponible
      return SectionData(
        color: isDarkMode ? const Color(0xFF00A8E8) : Colors.blue.shade600,
        title: 'Disponible',
        value: balance.available.toStringAsFixed(2),
      );
    case 1: // Pagado
      return SectionData(
        color: isDarkMode ? Colors.red.shade400 : Colors.red.shade700,
        title: 'Pagado',
        value: balance.locked.toStringAsFixed(2),
      );
    case 2: // Recycoins
      return SectionData(
        color: isDarkMode
            ? AppTheme.accentYellowColor
            : AppTheme.accentGreenColor,
        title: 'Recycoins',
        value: balance.recycoins.toStringAsFixed(2),
      );
    default:
      throw Exception('Índice no válido para la sección del gráfico');
  }
}

PieChartSectionData buildChartSection({
  required BuildContext context,
  required int index,
  required BalancePoint balance,
  required int touchedIndex,
}) {
  final isTouched = index == touchedIndex;
  final radius = isTouched ? 100.0 : 90.0;
  final sectionData = getSectionData(context, index, balance);
  final color = sectionData.color;
  final valueStr = sectionData.value;
  final parsed = double.tryParse(valueStr) ?? 0.0;
  final value = parsed > 0 ? parsed : 0.001;

  return PieChartSectionData(
    color: color.withValues(alpha: isTouched ? 1.0 : 0.85),
    value: value,
    title: '',
    showTitle: false,
    radius: radius,
  );
}
