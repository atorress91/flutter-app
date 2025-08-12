import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/l10n/app_localizations.dart';

class AdminSidebar extends StatelessWidget {
  const AdminSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1A1A2E),
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.dashboard, color: Colors.white),
            title: Text(AppLocalizations.of(context).sidebarDashboard, style: const TextStyle(color: Colors.white)),
            onTap: () => context.go('/admin/dashboard'),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.white),
            title: Text(AppLocalizations.of(context).sidebarLogoutToLogin, style: const TextStyle(color: Colors.white)),
            onTap: () => context.go('/auth/login'),
          ),
        ],
      ),
    );
  }
}