import 'package:flutter/material.dart';
import 'package:my_app/core/l10n/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person, size: 80, color: Colors.blueAccent),
          const SizedBox(height: 20),
          Text(AppLocalizations.of(context).profilePageTitle, style: const TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
