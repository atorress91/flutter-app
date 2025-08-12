import 'package:flutter/material.dart';
import 'package:my_app/core/l10n/app_localizations.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppLocalizations.of(context).adminDashboard, style: const TextStyle(fontSize: 24)),
    );
  }
}