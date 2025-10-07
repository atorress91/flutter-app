import 'package:flutter/material.dart';
import 'package:my_app/features/dashboard/presentation/widgets/app_navbar.dart';
import 'package:my_app/features/dashboard/presentation/widgets/sidebar/app_sidebar.dart';

class DashboardScreen extends StatefulWidget {
  final Widget child;

  const DashboardScreen({super.key, required this.child});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isSidebarCollapsed = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onMenuPressed(bool isMobile) {
    if (isMobile) {
      _scaffoldKey.currentState?.openDrawer();
    } else {
      setState(() {
        _isSidebarCollapsed = !_isSidebarCollapsed;
      });
    }
  }

  void _closeDrawer() {
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.of(context).pop();
    }
  }

  // Método para crear el background gradiente
  Widget _buildGradientBackground({required Widget child}) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary.withAlpha((255 * 0.1).toInt()),
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).colorScheme.surface.withAlpha((255 * 0.95).toInt()),
          ],
        ),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 900;

    if (isMobile) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppNavbar(onMenuPressed: () => _onMenuPressed(true)),
        drawer: Drawer(
          width: width * 0.85, // 85% del ancho en móviles
          backgroundColor: Theme.of(context).colorScheme.surface,
          child: AppSidebar(
            isCollapsed: false,
            onRequestClose: _closeDrawer,
          ),
        ),
        body: _buildGradientBackground(child: widget.child),
      );
    }

    return Scaffold(
      appBar: AppNavbar(onMenuPressed: () => _onMenuPressed(false)),
      body: _buildGradientBackground(
        child: Row(
          children: [
            AppSidebar(isCollapsed: _isSidebarCollapsed),
            Expanded(child: widget.child),
          ],
        ),
      ),
    );
  }
}