import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:my_app/features/dashboard/presentation/controllers/profile_screen_controller.dart';
import 'package:my_app/features/dashboard/presentation/widgets/profile/profile_header.dart';
import 'package:my_app/features/dashboard/presentation/widgets/profile/profile_info_card.dart';
import 'package:my_app/features/dashboard/presentation/widgets/profile/profile_status_badges.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileController = ref.read(profileScreenControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mi Perfil',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              ProfileHeader(
                onEdit: () async {
                  try {
                    await profileController.updateProfilePicture();
                    if(context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('¡Foto de perfil actualizada!')),
                      );
                    }
                  } catch (e) {
                    if(context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error al subir la imagen: $e')),
                      );
                    }
                  }
                },
              ),
              const SizedBox(height: 24),
              const ProfileStatusBadges(),
              const SizedBox(height: 32),
              const ProfileInfoCard(),
              const SizedBox(height: 32),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Editar Perfil'),
            onPressed: () {
              /* TODO: Implementar edición */
            },
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            icon: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.error,
            ),
            label: Text(
              'Cerrar Sesión',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            onPressed: () {
              /* TODO: Implementar cierre de sesión */
            },
          ),
        ),
      ],
    );
  }
}
