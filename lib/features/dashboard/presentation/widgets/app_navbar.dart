import 'package:flutter/material.dart';
import 'package:my_app/core/common/widgets/navbar_actions.dart';
import 'package:my_app/core/common/widgets/navbar_menu_button.dart';

class AppNavbar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuPressed;

  const AppNavbar({super.key, required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(''),
      centerTitle: true,
      leading: NavbarMenuButton(onPressed: onMenuPressed),
      actions: const [NavbarActions()],
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 1,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}