import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context).loginScreenTitle, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navega al dashboard del cliente al hacer login
                context.go('/dashboard');
              },
              child: Text(AppLocalizations.of(context).loginAsClient),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navega al dashboard de admin
                context.go('/admin/dashboard');
              },
              child: Text(AppLocalizations.of(context).loginAsAdmin),
            ),
          ],
        ),
      ),
    );
  }
}