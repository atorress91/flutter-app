import 'package:cached_network_image/cached_network_image.dart';
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
      padding: EdgeInsets.fromLTRB(16, isMobile ? 16 : 50, 16, 20),
      color: Theme.of(context).colorScheme.surface,
      child: Stack(
        children: [
          // Botón de cerrar en la parte superior derecha (solo móvil)
          if (!isCollapsed && isMobile && onRequestClose != null)
            Positioned(
              top: 0,
              right: 0,
              child: _buildCloseButton(context),
            ),
          // Contenido del header con padding para evitar superposición
          Padding(
            padding: EdgeInsets.only(top: isMobile ? 40 : 0),
            child: _buildHeaderContent(
              context,
              textTheme,
              displayName,
              secondaryText,
              imageUrl,
            ),
          ),
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
          child: (imageUrl != null && imageUrl.isNotEmpty)
              ? CachedNetworkImage(
                  imageUrl: imageUrl,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: avatarRadiusCollapsed,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primary.withAlpha((255 * 0.15).toInt()),
                    backgroundImage: imageProvider,
                  ),
                  placeholder: (context, url) => CircleAvatar(
                    radius: avatarRadiusCollapsed,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primary.withAlpha((255 * 0.15).toInt()),
                    child: SizedBox(
                      width: avatarRadiusCollapsed * 0.6,
                      height: avatarRadiusCollapsed * 0.6,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    radius: avatarRadiusCollapsed,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primary.withAlpha((255 * 0.15).toInt()),
                    child: Text(
                      _initialsFrom(name),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                )
              : CircleAvatar(
                  radius: avatarRadiusCollapsed,
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primary.withAlpha((255 * 0.15).toInt()),
                  child: Text(
                    _initialsFrom(name),
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
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
              child: (imageUrl != null && imageUrl.isNotEmpty)
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: avatarRadiusExpanded,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primary.withAlpha((255 * 0.15).toInt()),
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (context, url) => CircleAvatar(
                        radius: avatarRadiusExpanded,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primary.withAlpha((255 * 0.15).toInt()),
                        child: SizedBox(
                          width: avatarRadiusExpanded * 0.6,
                          height: avatarRadiusExpanded * 0.6,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => CircleAvatar(
                        radius: avatarRadiusExpanded,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primary.withAlpha((255 * 0.15).toInt()),
                        child: Text(
                          _initialsFrom(name),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    )
                  : CircleAvatar(
                      radius: avatarRadiusExpanded,
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primary.withAlpha((255 * 0.15).toInt()),
                      child: Text(
                        _initialsFrom(name),
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
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
