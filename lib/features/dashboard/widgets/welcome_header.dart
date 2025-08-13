import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/core/l10n/app_localizations.dart';

import '../screens/profile_screen.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).homeWelcomeBack,
              style: GoogleFonts.poppins(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withAlpha((255 * 0.7).toInt()),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'André', // Esto debería ser dinámico con los datos del usuario
              style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        // Envolvemos el CircleAvatar para hacerlo táctil
        GestureDetector(
          onTap: () {
            // Navegamos a la nueva pantalla de perfil
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          },
          child: const Hero(
            tag: 'user_avatar', // Tag para una bonita animación de transición
            child: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/150?u=laurap',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
