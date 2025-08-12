import 'package:flutter/material.dart';
import 'package:my_app/features/dashboard/widgets/app_navbar.dart';
import 'package:my_app/features/dashboard/widgets/app_sidebar.dart';

// Layout con comportamiento responsive: Drawer en móvil, sidebar fijo en escritorio
class DashboardLayout extends StatefulWidget {
  final Widget child;
  const DashboardLayout({super.key, required this.child});

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> {
  // Estado para controlar si el sidebar está colapsado (solo relevante en desktop/tablet ancha)
  bool _isSidebarCollapsed = false;

  // Key para abrir el Drawer en móvil
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // Puedes ajustar el breakpoint según tu diseño
    final bool isMobile = width < 900;

    if (isMobile) {
      // Móvil: usar Drawer que se sobrepone al contenido principal
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppNavbar(onMenuPressed: () => _onMenuPressed(true)),
        drawer: Drawer(
          backgroundColor: Theme.of(context).colorScheme.surface,
          child: SafeArea(
            child: AppSidebar(
              isCollapsed: false,
              onRequestClose: () => Navigator.of(context).maybePop(),
            ),
          ),
        ),
        body: widget.child,
        // Footer no se muestra en móvil.
        bottomNavigationBar: null,
      );
    }

    // Escritorio/Tablet ancho: sidebar permanente junto al contenido
    return Scaffold(
      appBar: AppNavbar(onMenuPressed: () => _onMenuPressed(false)),
      body: Row(
        children: [
          AppSidebar(
            isCollapsed: _isSidebarCollapsed,
          ),
          Expanded(
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
