import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/features/auth/presentation/providers/auth_state_provider.dart';

class ProfileHeader extends ConsumerWidget {
  final VoidCallback onEdit;

  const ProfileHeader({
    super.key,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final user = authState.asData?.value?.user;
    final typography = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Hero(
              tag: 'user_avatar',
              child: CircleAvatar(
                radius: 50,
                backgroundColor: colorScheme.surface,
                backgroundImage: (user?.imageUrl != null && user!.imageUrl!.isNotEmpty)
                    ? CachedNetworkImageProvider(user.imageUrl!)
                    : null,
                child: (user?.imageUrl == null || user!.imageUrl!.isEmpty)
                    ? Icon(
                  Icons.person,
                  size: 50,
                  color: colorScheme.onSurface.withAlpha((255*0.5).toInt()),
                )
                    : null,
              ),
            ),
            Positioned(
              bottom: 0,
              right: -5,
              child: Material(
                color: colorScheme.primary,
                shape: const CircleBorder(),
                elevation: 2,
                child: InkWell(
                  onTap: onEdit,
                  customBorder: const CircleBorder(),
                  child: const SizedBox(
                    width: 32,
                    height: 32,
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          user?.fullName ?? 'Nombre de Usuario',
          style: GoogleFonts.poppins(
            textStyle: typography.headlineSmall,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          user?.email ?? 'email@example.com',
          style: typography.bodyMedium?.copyWith(color: colorScheme.onSurface.withAlpha((255*0.6).toInt())),
        ),
      ],
    );
  }
}