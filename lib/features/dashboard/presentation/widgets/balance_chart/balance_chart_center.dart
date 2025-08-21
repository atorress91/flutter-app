import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/features/dashboard/presentation/models/balance_chart_view_model.dart';
import 'balance_chart_section.dart';

class BalanceChartCenter extends StatelessWidget {
  final int touchedIndex;
  final BalanceChartViewModel viewModel;

  const BalanceChartCenter({
    super.key,
    required this.touchedIndex,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    final String title;
    final String amount;
    final Color color;

    if (touchedIndex == -1) {
      title = 'Balance Total';
      amount =
          '${viewModel.currencySymbol}${viewModel.latestBalance.total.toStringAsFixed(2)}';
      color = Theme.of(context).textTheme.bodyLarge!.color!;
    } else {
      final sectionData = getSectionData(touchedIndex, viewModel.latestBalance);
      title = sectionData.title;
      amount = '${viewModel.currencySymbol}${sectionData.value}';
      color = sectionData.color;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: color.withAlpha((255 * 0.8).toInt()),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          amount,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
