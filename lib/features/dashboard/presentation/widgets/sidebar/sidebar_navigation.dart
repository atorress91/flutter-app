import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'sidebar_constants.dart';

class SidebarNavigation {
  static Future<void> navigate(
      BuildContext context,
      String route, {
        VoidCallback? onRequestClose,
      }) async {
    // Si estamos en móvil con Drawer, cerramos antes de navegar
    if (onRequestClose != null) {
      onRequestClose();
      // Esperamos un frame para que el drawer se cierre completamente
      await Future.delayed(navigationDelay);
    }

    // Verificamos que el contexto siga siendo válido
    if (context.mounted) {
      context.go(route);
    }
  }

  static bool isRouteSelected(String currentRoute, String targetRoute) {
    if (targetRoute.startsWith('/admin')) {
      return currentRoute.startsWith('/admin');
    }
    return currentRoute == targetRoute;
  }
}