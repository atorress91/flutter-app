import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/features/dashboard/widgets/sidebar/sidebar_constants.dart';
import 'package:my_app/features/dashboard/widgets/sidebar/sidebar_header.dart';
import 'package:my_app/features/dashboard/widgets/sidebar/sidebar_menu_item.dart';
import 'package:my_app/features/dashboard/widgets/sidebar/sidebar_navigation.dart';

class AppSidebar extends StatelessWidget {
  final bool isCollapsed;
  final VoidCallback? onRequestClose;

  const AppSidebar({
    super.key,
    required this.isCollapsed,
    this.onRequestClose,
  });

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).matchedLocation;

    return AnimatedContainer(
      duration: sidebarAnimationDuration,
      curve: Curves.easeInOutCubic,
      width: isCollapsed ? sidebarCollapsedWidth : sidebarExpandedWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).dividerColor,
            width: sidebarBorderWidth,
          ),
        ),
      ),
      child: Column(
        children: [
          SidebarHeader(
            isCollapsed: isCollapsed,
            onRequestClose: onRequestClose,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _buildMenuItems(context, currentRoute),
          ),
          _buildFooter(context, currentRoute),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context, String currentRoute) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        SidebarMenuItem(
          title: 'Inicio',
          icon: Icons.home_filled,
          isCollapsed: isCollapsed,
          isSelected: SidebarNavigation.isRouteSelected(
            currentRoute,
            '/dashboard',
          ),
          onTap: () => SidebarNavigation.navigate(
            context,
            '/dashboard',
            onRequestClose: onRequestClose,
          ),
        ),
        SidebarMenuItem(
          title: 'Mis compras',
          icon: Icons.shopping_bag,
          isCollapsed: isCollapsed,
          isSelected: SidebarNavigation.isRouteSelected(
            currentRoute,
            '/dashboard/purchases',
          ),
          onTap: () => SidebarNavigation.navigate(
            context,
            '/dashboard/purchases',
            onRequestClose: onRequestClose,
          ),
        ),
        SidebarMenuItem(
          title: 'Mis Clientes',
          icon: Icons.people_alt_outlined,
          isCollapsed: isCollapsed,
          isSelected: SidebarNavigation.isRouteSelected(
            currentRoute,
            '/dashboard/clients',
          ),
          onTap: () => SidebarNavigation.navigate(
            context,
            '/dashboard/clients',
            onRequestClose: onRequestClose,
          ),
        ),
        SidebarMenuItem(
          title: 'Solicitar pago',
          icon: Icons.payment_outlined,
          isCollapsed: isCollapsed,
          isSelected: SidebarNavigation.isRouteSelected(
            currentRoute,
            '/dashboard/request-payment',
          ),
          onTap: () => SidebarNavigation.navigate(
            context,
            '/dashboard/request-payment',
            onRequestClose: onRequestClose,
          ),
        ),
        SidebarMenuItem(
          title: 'Mi billetera',
          icon: Icons.account_balance_wallet,
          isCollapsed: isCollapsed,
          isSelected: SidebarNavigation.isRouteSelected(
            currentRoute,
            '/dashboard/my-wallet',
          ),
          onTap: () => SidebarNavigation.navigate(
            context,
            '/dashboard/my-wallet',
            onRequestClose: onRequestClose,
          ),
        ),
        SidebarMenuItem(
          title: 'Servicio al cliente',
          icon: Icons.support_agent_outlined,
          isCollapsed: isCollapsed,
          isSelected: SidebarNavigation.isRouteSelected(
            currentRoute,
            '/dashboard/customer-service',
          ),
          onTap: () => SidebarNavigation.navigate(
            context,
            '/dashboard/customer-service',
            onRequestClose: onRequestClose,
          ),
        ),
        SidebarMenuItem(
          title: 'Panel Admin',
          icon: Icons.admin_panel_settings,
          isCollapsed: isCollapsed,
          isSelected: SidebarNavigation.isRouteSelected(
            currentRoute,
            '/admin',
          ),
          onTap: () => SidebarNavigation.navigate(
            context,
            '/admin/dashboard',
            onRequestClose: onRequestClose,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context, String currentRoute) {
    return Column(
      children: [
        Divider(
          color: Theme.of(context).dividerColor,
          indent: 16,
          endIndent: 16,
        ),
        SidebarMenuItem(
          title: 'Cerrar Sesión',
          icon: Icons.logout,
          isCollapsed: isCollapsed,
          isSelected: false,
          onTap: () => SidebarNavigation.navigate(
            context,
            '/auth/login',
            onRequestClose: onRequestClose,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}