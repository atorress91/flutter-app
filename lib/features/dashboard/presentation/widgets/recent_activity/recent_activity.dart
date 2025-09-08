import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import 'package:my_app/features/dashboard/data/home_data.dart';
import 'package:my_app/features/dashboard/presentation/widgets/recent_activity/activity_item.dart';

class RecentActivity extends StatelessWidget {
  const RecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = HomeData.getRecentActivitiesData();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        children: activities.map((activity) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ActivityItem(
              title: AppLocalizations.of(
                context,
              ).t(activity['titleKey'] as String),
              subtitle: AppLocalizations.of(
                context,
              ).t(activity['subtitleKey'] as String),
              icon: activity['icon'] as IconData,
              color: activity['color'] as Color,
              onTap: () {
                // TODO: Implement activity tap handler
                GoRouter.of(context).go(activity['route'] as String);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}


