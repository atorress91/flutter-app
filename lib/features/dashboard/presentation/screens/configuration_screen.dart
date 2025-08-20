import 'package:flutter/material.dart';
import 'package:my_app/core/l10n/app_localizations.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.settings, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          Text(AppLocalizations.of(context).configPageTitle, style: const TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
