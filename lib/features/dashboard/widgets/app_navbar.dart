import 'package:flutter/material.dart';
import '../../../core/common/widgets/navbar_actions.dart';
import '../../../core/common/widgets/navbar_menu_button.dart';

class AppNavbar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuPressed;

  const AppNavbar({super.key, required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(''),
      centerTitle: true,
      leading: NavbarMenuButton(onPressed: onMenuPressed),
      actions: const [NavbarActions()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}