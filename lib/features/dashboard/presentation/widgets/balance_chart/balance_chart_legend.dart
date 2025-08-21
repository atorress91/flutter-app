import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/features/dashboard/presentation/models/balance_chart_view_model.dart';
import 'balance_chart_section.dart';

class BalanceChartLegend extends StatelessWidget {
  final BalancePoint balance;

  const BalanceChartLegend({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _LegendItem(
          // Obtenemos el color desde la misma fuente que el gráfico
          color: getSectionData(0, balance).color,
          text: 'Disponible',
          amount: balance.available,
        ),
        _LegendItem(
          color: getSectionData(1, balance).color,
          text: 'Bloqueado',
          amount: balance.locked,
        ),
        _LegendItem(
          color: getSectionData(2, balance).color,
          text: 'Recycoins',
          amount: balance.recycoins,
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;
  final double amount;

  const _LegendItem({
    required this.color,
    required this.text,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
            const SizedBox(width: 8),
            Text(
              text,
              // Aplicamos el color al texto principal de la leyenda
              style: textTheme.bodyMedium?.copyWith(color: color),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: color.withAlpha((255 * 0.8).toInt()),
          ),
        ),
      ],
    );
  }
}
