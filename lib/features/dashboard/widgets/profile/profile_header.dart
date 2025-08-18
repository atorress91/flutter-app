import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/core/providers/auth_providers.dart';

class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSession = ref.watch(authNotifierProvider);
    final user = asyncSession.value?.user; // UsersAffiliatesDto?

    final displayName = () {
      if (user == null) return '';
      final name = user.name;
      final last = user.lastName;
      if (name != null && name.isNotEmpty) {
        return last != null && last.isNotEmpty ? '$name $last' : name;
      }
      if (user.userName.isNotEmpty) return user.userName;
      return user.email;
    }();

    final secondary = () {
      if (user == null) return '';
      if (user.userName.isNotEmpty) return '@${user.userName}';
      return user.email;
    }();

    final imageUrl = user?.imageProfileUrl;

    return Column(
      children: [
        Hero(
          tag: 'user_avatar',
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context)
                .colorScheme
                .primary
                .withAlpha((255 * 0.15).toInt()),
            backgroundImage:
                (imageUrl != null && imageUrl.isNotEmpty) ? NetworkImage(imageUrl) : null,
            child: (imageUrl == null || imageUrl.isEmpty)
                ? Text(
                    _initialsFrom(displayName),
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                : null,
          ),
        ),
        const SizedBox(height: 16),
        if (user == null)
          Container(
            width: 140,
            height: 24,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface.withAlpha((255 * 0.08).toInt()),
              borderRadius: BorderRadius.circular(6),
            ),
          )
        else
          Text(
            displayName,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            softWrap: false,
            style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        const SizedBox(height: 4),
        Text(
          secondary,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: false,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSurface.withAlpha((255 * 0.6).toInt()),
          ),
        ),
      ],
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
