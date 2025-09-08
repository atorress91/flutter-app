import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import 'package:my_app/features/dashboard/data/home_data.dart';

import 'quick_action_button.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = HomeData.getQuickActionsData();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: actions.map((action) {
        return QuickActionButton(
          icon: action['icon'] as IconData,
          label: AppLocalizations.of(context).t(action['labelKey'] as String),
          color: action['color'] as Color,
          onTap: () {
            context.go(action['route'] as String);
          },
        );
      }).toList(),
    );
  }
}
