import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

// Constantes para los anchos, fácil de modificar
const double _sidebarExpandedWidth = 250;
const double _sidebarCollapsedWidth = 80;

class AppSidebar extends StatelessWidget {
  // Recibe el estado de colapso desde el layout
  final bool isCollapsed;

  // Callback opcional para solicitar el cierre (útil en móvil con Drawer)
  final VoidCallback? onRequestClose;

  const AppSidebar({super.key, required this.isCollapsed, this.onRequestClose});

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).matchedLocation;

    void navigate(String route) async {
      // Si estamos en móvil con Drawer, cerramos antes de navegar
      if (onRequestClose != null) {
        onRequestClose!();
        // Esperamos un frame para que el drawer se cierre completamente
        await Future.delayed(const Duration(milliseconds: 100));
      }
      
      // Verificamos que el contexto siga siendo válido
      if (context.mounted) {
        context.go(route);
      }
    }

    // AnimatedContainer se encarga de la animación de cambio de tamaño
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      width: isCollapsed ? _sidebarCollapsedWidth : _sidebarExpandedWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          right: BorderSide(color: Theme.of(context).dividerColor, width: 1),
        ),
      ),
      child: Column(
        children: [
          _SidebarHeader(
            isCollapsed: isCollapsed,
            onRequestClose: onRequestClose,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _SidebarMenuItem(
                  title: 'Inicio',
                  icon: Icons.home_filled,
                  isCollapsed: isCollapsed,
                  isSelected: currentRoute == '/dashboard',
                  onTap: () => navigate('/dashboard'),
                ),
                _SidebarMenuItem(
                  title: 'Mis compras',
                  icon: Icons.shopping_bag,
                  isCollapsed: isCollapsed,
                  isSelected: currentRoute == '/dashboard/purchases',
                  onTap: () => navigate('/dashboard/purchases'),
                ),
                _SidebarMenuItem(
                  title: 'Mis Clientes',
                  icon: Icons.people_alt_outlined,
                  isCollapsed: isCollapsed,
                  isSelected: currentRoute == '/dashboard/clients',
                  onTap: () => navigate('/dashboard/clients'),
                ),
                // elementos del menú
                _SidebarMenuItem(
                  title: 'Panel Admin',
                  icon: Icons.admin_panel_settings,
                  isCollapsed: isCollapsed,
                  isSelected: currentRoute.startsWith('/admin'),
                  onTap: () => navigate('/admin/dashboard'),
                ),
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).dividerColor,
            indent: 16,
            endIndent: 16,
          ),
          _SidebarMenuItem(
            title: 'Cerrar Sesión',
            icon: Icons.logout,
            isCollapsed: isCollapsed,
            isSelected: false,
            onTap: () => navigate('/auth/login'),
          ),
          // Espacio en la parte inferior para que el botón no quede pegado
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

// --- WIDGETS INTERNOS ---

class _SidebarHeader extends StatelessWidget {
  final bool isCollapsed;
  final VoidCallback? onRequestClose;

  const _SidebarHeader({required this.isCollapsed, this.onRequestClose});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 900;

    Widget content = AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) =>
          FadeTransition(opacity: animation, child: child),
      child: isCollapsed
          ? const CircleAvatar(
              key: ValueKey('collapsed_header'),
              radius: 24,
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/150?u=andre',
              ),
            )
          : Column(
              key: ValueKey('expanded_header'),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/150?u=andre',
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'André',
                  style: textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'andre.dev@email.com',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha((255 * 0.6).toInt()),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
      color: Theme.of(context).colorScheme.surface,
      child: Stack(
        children: [
          // Main header content
          Align(alignment: Alignment.centerLeft, child: content),
          // Mobile-only close button when expanded
          if (!isCollapsed && isMobile && onRequestClose != null)
            Positioned(
              top: 8,
              right: 8,
              child: Tooltip(
                message: 'Cerrar',
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha((255 * 0.7).toInt()),
                  ),
                  onPressed: onRequestClose,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// --- WIDGET DE ITEM DEL MENÚ  ---

class _SidebarMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final bool isCollapsed;
  final VoidCallback onTap;

  const _SidebarMenuItem({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.isCollapsed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Tooltip(
      message: title,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: theme.primary.withAlpha((255 * 0.2).toInt()),
        highlightColor: theme.primary.withAlpha((255 * 0.1).toInt()),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          padding: EdgeInsets.symmetric(
            vertical: 12,
            // Reducimos ligeramente el padding horizontal para evitar overflow sutiles
            horizontal: isCollapsed ? 0 : 12,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.primary.withAlpha((255 * 0.1).toInt())
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: isCollapsed
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: isSelected
                    ? theme.primary
                    : Theme.of(
                        context,
                      ).colorScheme.onSurface.withAlpha((255 * 0.7).toInt()),
                size: 24,
              ),
              // Si no está colapsado, envolvemos el texto en un Expanded.
              if (!isCollapsed)
                Expanded(
                  child: Padding(
                    // Añadimos el padding aquí para separar el texto del ícono
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(
                        color: isSelected
                            ? Theme.of(context).colorScheme.onSurface
                            : Theme.of(
                                context,
                              ).colorScheme.onSurface.withAlpha((255*0.7).toInt()),
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                        fontSize: 15,
                      ),
                      maxLines: 1, // Asegura que el texto no salte de línea
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
