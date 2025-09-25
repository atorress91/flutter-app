import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/features/dashboard/presentation/models/balance_chart_view_model.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import 'balance_chart_section.dart';

class BalanceChartCenter extends StatelessWidget {
  final int touchedIndex;
  final BalanceChartViewModel viewModel;
  final BalancePoint? animatedBalance;

  const BalanceChartCenter({
    super.key,
    required this.touchedIndex,
    required this.viewModel,
    this.animatedBalance,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    final String title;
    final String amount;
    final Color color;

    final balanceForDisplay = animatedBalance ?? viewModel.latestBalance;

    if (touchedIndex == -1) {
      title = AppLocalizations.of(context).t('balanceTotal');
      amount =
          '${viewModel.currencySymbol}${balanceForDisplay.total.toStringAsFixed(2)}';
      color = Theme.of(context).textTheme.bodyLarge!.color!;
    } else {
      final sectionData = getSectionData(
        context,
        touchedIndex,
        viewModel.latestBalance,
      );
      title = sectionData.title;
      switch (touchedIndex) {
        case 0:
          amount =
              '${viewModel.currencySymbol}${balanceForDisplay.available.toStringAsFixed(2)}';
          break;
        case 1:
          amount =
              '${viewModel.currencySymbol}${balanceForDisplay.locked.toStringAsFixed(2)}';
          break;
        case 2:
          amount = '${balanceForDisplay.recycoins.toStringAsFixed(2)} RC';
          break;
        default:
          amount =
              '${viewModel.currencySymbol}${balanceForDisplay.total.toStringAsFixed(2)}';
      }
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
