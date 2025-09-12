import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/core/utils/date_formatter.dart';
import 'package:my_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:my_app/features/dashboard/presentation/widgets/profile/profile_header.dart';
import 'package:my_app/features/dashboard/presentation/widgets/profile/profile_info_card.dart';
import 'package:my_app/features/dashboard/presentation/widgets/sidebar/sidebar_navigation.dart';

import '../controllers/profile_screen_controller.dart'
    show profileScreenControllerProvider;

class ProfileScreen extends ConsumerWidget {
  final VoidCallback? onRequestClose;
  const ProfileScreen({super.key, this.onRequestClose});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileController = ref.read(profileScreenControllerProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final asyncSession = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mi Perfil',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        foregroundColor: colorScheme.onSurface,
      ),
      backgroundColor: colorScheme.surface,
      body: asyncSession.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stackTrace) =>
            Center(child: Text('Ocurrió un error: $err')),
        data: (session) {
          final user = session?.user;

          if (user == null) {
            return const Center(
              child: Text('No se encontraron datos del usuario.'),
            );
          }

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: [
                  ProfileHeader(
                    onEdit: () async {
                      try {
                        final success = await profileController
                            .updateProfilePicture();

                        if (success && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('¡Foto de perfil actualizada!'),
                            ),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error al subir la imagen: $e'),
                            ),
                          );
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 32),
                  ProfileInfoCard(
                    title: 'Datos Principales',
                    icon: Icons.person_outline,
                    info: {
                      'Usuario': user.userName,
                      'Correo': user.email,
                      'Identificación': user.identification,
                      'Fecha de Registro': DateFormatter.ddMMyyyy(
                        user.createdAt,
                      ),
                      'Fecha de Nacimiento': user.birthDay != null
                          ? DateFormatter.ddMMyyyy(user.birthDay)
                          : 'No especificada',
                    },
                  ),
                  const SizedBox(height: 16),

                  ProfileInfoCard(
                    title: 'Datos Secundarios',
                    icon: Icons.location_on_outlined,
                    info: {
                      'Nombre': user.name ?? '',
                      'Apellido': user.lastName ?? '',
                      'Dirección': user.address ?? '',
                      'Teléfono': user.phone ?? '',
                    },
                  ),
                  const SizedBox(height: 16),

                  ProfileInfoCard(
                    title: 'Adicionales',
                    icon: Icons.favorite_border,
                    info: {
                      'Nombre Beneficiario': user.beneficiaryName ?? '',
                      'Correo del Beneficiario': user.beneficiaryEmail ?? '',
                      'Teléfono del Beneficiario': user.beneficiaryPhone ?? '',
                    },
                  ),

                  const SizedBox(height: 32),
                  _buildActionButtons(context, ref), // Pasamos ref
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Editar Perfil'),
            onPressed: () {
              // TODO: Implementar edición de datos del perfil
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
            onPressed: () => SidebarNavigation.navigate(
              context,
              '/auth/login',
              onRequestClose: onRequestClose,
            ),
          ),
        ),
      ],
    );
  }
}
