import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/features/auth/presentation/providers/auth_state_provider.dart';
import '../../screens/profile_screen.dart';
import 'sidebar_constants.dart';

class SidebarHeader extends ConsumerWidget {
  final bool isCollapsed;
  final VoidCallback? onRequestClose;

  const SidebarHeader({
    super.key,
    required this.isCollapsed,
    this.onRequestClose,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSession = ref.watch(authNotifierProvider);
    final user = asyncSession.value?.user;

    final displayName = () {
      if (user == null) return '';

      if (user.fullName != null && user.fullName!.isNotEmpty) {
        return user.fullName!;
      }

      if (user.userName.isNotEmpty) return user.userName;
      return user.email;
    }();

    final secondaryText = user?.email ?? '';
    final imageUrl = user?.imageUrl;

    final textTheme = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 900;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
      color: Theme.of(context).colorScheme.surface,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: _buildHeaderContent(
              context,
              textTheme,
              displayName,
              secondaryText,
              imageUrl,
            ),
          ),
          if (!isCollapsed && isMobile && onRequestClose != null)
            _buildCloseButton(context),
        ],
      ),
    );
  }

  Widget _buildHeaderContent(
    BuildContext context,
    TextTheme textTheme,
    String name,
    String subtitle,
    String? imageUrl,
  ) {
    return SizedBox(
      width: double.infinity,
      child: AnimatedSwitcher(
        duration: headerAnimationDuration,
        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),
        child: isCollapsed
            ? _buildCollapsedHeader(context, name, imageUrl)
            : _buildExpandedHeader(
                context,
                textTheme,
                name,
                subtitle,
                imageUrl,
              ),
      ),
    );
  }

  Widget _buildCollapsedHeader(
    BuildContext context,
    String name,
    String? imageUrl,
  ) {
    return Center(
      key: const ValueKey('collapsed_header'),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        },
        child: Hero(
          tag: 'user_avatar',
          child: CircleAvatar(
            radius: avatarRadiusCollapsed,
            backgroundColor: Theme.of(
              context,
            ).colorScheme.primary.withAlpha((255 * 0.15).toInt()),
            backgroundImage: (imageUrl != null && imageUrl.isNotEmpty)
                ? NetworkImage(imageUrl)
                : null,
            child: (imageUrl == null || imageUrl.isEmpty)
                ? Text(
                    _initialsFrom(name),
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedHeader(
    BuildContext context,
    TextTheme textTheme,
    String name,
    String subtitle,
    String? imageUrl,
  ) {
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
            child: Hero(
              tag: 'user_avatar',
              child: CircleAvatar(
                radius: avatarRadiusExpanded,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.primary.withAlpha((255 * 0.15).toInt()),
                backgroundImage: (imageUrl != null && imageUrl.isNotEmpty)
                    ? NetworkImage(imageUrl)
                    : null,
                child: (imageUrl == null || imageUrl.isEmpty)
                    ? Text(
                        _initialsFrom(name),
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name.isEmpty ? '' : name,
          style: textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          subtitle,
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

String _initialsFrom(String name) {
  if (name.trim().isEmpty) return '';
  final parts = name
      .trim()
      .split(RegExp(r"\s+"))
      .where((p) => p.isNotEmpty)
      .toList();
  if (parts.isEmpty) return '';
  if (parts.length == 1) return parts.first[0].toUpperCase();
  return (parts[0][0] + parts[1][0]).toUpperCase();
}
