import 'package:flutter/material.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import '../../data/home_data.dart';
import 'stat_card.dart';

class StatsCarousel extends StatelessWidget {
  const StatsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = HomeData.getStatsData();

    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: stats.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final stat = stats[index];
          return StatCard(
            title: AppLocalizations.of(context).t(stat['titleKey'] as String),
            value: stat['value'] as String,
            icon: stat['icon'] as IconData,
            color: stat['color'] as Color,
          );
        },
      ),
    );
  }
}