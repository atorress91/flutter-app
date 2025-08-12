import 'package:flutter/material.dart';
import 'package:my_app/core/l10n/app_localizations.dart';

class NavbarMenuButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NavbarMenuButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.menu_rounded,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black87,
        size: 28,
      ),
      onPressed: onPressed,
      tooltip: AppLocalizations.of(context).menuTooltip,
    );
  }
}