import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/core/utils/date_formatter.dart';
import 'package:my_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:my_app/features/dashboard/presentation/widgets/profile/profile_header.dart';
import 'package:my_app/features/dashboard/presentation/widgets/profile/profile_info_card.dart';

import '../controllers/profile_screen_controller.dart'
    show profileScreenControllerProvider;

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileController = ref.read(profileScreenControllerProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final asyncSession = ref.watch(authNotifierProvider);
    final user = asyncSession.value?.user;

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
      body: SafeArea(
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
                        SnackBar(content: Text('Error al subir la imagen: $e')),
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
                  'Usuario': user!.userName,
                  'Correo': user.email,
                  'Identificación': user.identification,
                  'Fecha de Registro': DateFormatter.ddMMyyyy(user.createdAt),
                  'Fecha de Nacimiento': user.birthDay != null ? DateFormatter.ddMMyyyy(user.birthDay) : '',
                },
              ),
              const SizedBox(height: 16),

              ProfileInfoCard(
                title: 'Datos Secundarios',
                icon: Icons.location_on_outlined,
                info: {
                  'Nombre': 'Nombre',
                  'Apellido': 'Apellido',
                  'Dirección': 'Dirección de ejemplo, 123',
                  'Teléfono': '+123 456 7890',
                  'Código Postal': '12345',
                  'País': 'País Ejemplo',
                },
              ),
              const SizedBox(height: 16),

              ProfileInfoCard(
                title: 'Adicionales',
                icon: Icons.favorite_border,
                info: {
                  'Nombre Beneficiario': 'Nombre Beneficiario',
                  'Correo del Beneficiario': 'beneficiario@correo.com',
                  'Teléfono del Beneficiario': '+098 765 4321',
                },
              ),

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
            onPressed: () {
              // TODO: Implementar cierre de sesión
            },
          ),
        ),
      ],
    );
  }
}
