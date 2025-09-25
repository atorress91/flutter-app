import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/features/dashboard/presentation/widgets/sidebar/sidebar_constants.dart';
import 'package:my_app/features/dashboard/presentation/widgets/sidebar/sidebar_header.dart';
import 'package:my_app/features/dashboard/presentation/widgets/sidebar/sidebar_menu_item.dart';
import 'package:my_app/features/dashboard/presentation/widgets/sidebar/sidebar_navigation.dart';
import 'package:my_app/core/l10n/app_localizations.dart';

class AppSidebar extends StatelessWidget {
  final bool isCollapsed;
  final VoidCallback? onRequestClose;

  const AppSidebar({super.key, required this.isCollapsed, this.onRequestClose});

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).matchedLocation;
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: sidebarAnimationDuration,
      curve: Curves.easeInOutCubic,
      width: isCollapsed ? sidebarCollapsedWidth : sidebarExpandedWidth,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary.withAlpha((255 * 0.15).toInt()),
            theme.scaffoldBackgroundColor,
            theme.colorScheme.surface.withAlpha((255 * 0.9).toInt()),
          ],
        ),
        border: Border(
          right: BorderSide(
            color: theme.dividerColor.withAlpha((255 * 0.3).toInt()),
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
          Expanded(child: _buildMenuItems(context, currentRoute)),
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
          title: AppLocalizations.of(context).t('sidebarHome'),
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
          title: AppLocalizations.of(context).t('sidebarPurchases'),
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
          title: AppLocalizations.of(context).t('sidebarClients'),
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
          title: AppLocalizations.of(context).t('sidebarRequestPayment'),
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
          title: AppLocalizations.of(context).t('sidebarMyWallet'),
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
        // SidebarMenuItem(
        //   title: AppLocalizations.of(context).t('sidebarCustomerService'),
        //   icon: Icons.support_agent_outlined,
        //   isCollapsed: isCollapsed,
        //   isSelected: SidebarNavigation.isRouteSelected(
        //     currentRoute,
        //     '/dashboard/customer-service',
        //   ),
        //   onTap: () => SidebarNavigation.navigate(
        //     context,
        //     '/dashboard/customer-service',
        //     onRequestClose: onRequestClose,
        //   ),
        // )
      ],
    );
  }

  Widget _buildFooter(BuildContext context, String currentRoute) {
    return Column(
      children: [
        Divider(
          color: Theme.of(context).dividerColor.withAlpha((255 * 0.3).toInt()),
          indent: 16,
          endIndent: 16,
        ),
        SidebarMenuItem(
          title: AppLocalizations.of(context).t('sidebarLogout'),
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