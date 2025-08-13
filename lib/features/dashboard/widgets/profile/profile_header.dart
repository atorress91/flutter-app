import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Hero(
          tag: 'user_avatar',
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=laurap'),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Laura Ponce',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          '@Laurap',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withAlpha((255 * 0.6).toInt()),
          ),
        ),
      ],
    );
  }
}
