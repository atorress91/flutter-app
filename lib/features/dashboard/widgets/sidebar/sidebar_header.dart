import 'package:flutter/material.dart';
import '../../screens/profile_screen.dart';
import 'sidebar_constants.dart';

class SidebarHeader extends StatelessWidget {
  final bool isCollapsed;
  final VoidCallback? onRequestClose;

  const SidebarHeader({
    super.key,
    required this.isCollapsed,
    this.onRequestClose,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 900;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
      color: Theme.of(context).colorScheme.surface,
      child: Stack(
        children: [
          // Main header content
          Align(
            alignment: Alignment.centerLeft,
            child: _buildHeaderContent(context, textTheme),
          ),
          // Mobile-only close button when expanded
          if (!isCollapsed && isMobile && onRequestClose != null)
            _buildCloseButton(context),
        ],
      ),
    );
  }

  Widget _buildHeaderContent(BuildContext context, TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      child: AnimatedSwitcher(
        duration: headerAnimationDuration,
        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),
        child: isCollapsed
            ? _buildCollapsedHeader(context)
            : _buildExpandedHeader(context, textTheme),
      ),
    );
  }

  Widget _buildCollapsedHeader(BuildContext context) {
    return Center(
      key: const ValueKey('collapsed_header'),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        },
        child: const Hero(
          tag: 'user_avatar',
          child: CircleAvatar(
            radius: avatarRadiusCollapsed,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=laurap'),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedHeader(BuildContext context, TextTheme textTheme) {
    return Column(
      key: const ValueKey('expanded_header'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: const Hero(
              tag: 'user_avatar',
              child: CircleAvatar(
                radius: avatarRadiusExpanded,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?u=laurap',
                ),
              ),
            ),
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
          'andres.dev@email.com',
          style: textTheme.bodyMedium?.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withAlpha((255 * 0.6).toInt()),
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Positioned(
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
    );
  }
}
