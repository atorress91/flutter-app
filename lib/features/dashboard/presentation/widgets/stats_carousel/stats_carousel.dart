import 'package:flutter/material.dart';
import 'package:my_app/core/common/widgets/info_card.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import 'package:my_app/features/dashboard/data/home_data.dart';
import 'package:my_app/features/dashboard/domain/entities/balance_information.dart';

class StatsCarousel extends StatelessWidget {
  final BalanceInformation balance;

  const StatsCarousel({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    final stats = HomeData.getStatsData(balance);

    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: stats.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final stat = stats[index];
          return SizedBox(
            width: 160,
            child: InfoCard(
              title: AppLocalizations.of(context).t(stat['titleKey'] as String),
              value: stat['value'] as String,
              icon: stat['icon'] as IconData,
              color: stat['color'] as Color,
            ),
          );
        },
      ),
    );
  }
}