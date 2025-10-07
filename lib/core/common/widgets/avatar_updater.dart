import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/features/dashboard/presentation/controllers/profile_screen_controller.dart';

class AvatarUpdater extends ConsumerWidget {
  final Widget child;
  final VoidCallback? onSuccess;
  final Function(String error)? onError;

  const AvatarUpdater({
    super.key,
    required this.child,
    this.onSuccess,
    this.onError,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileController = ref.read(profileScreenControllerProvider);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _updateAvatar(context, profileController),
      child: IgnorePointer(
        ignoring: false,
        child: child,
      ),
    );
  }

  Future<void> _updateAvatar(
    BuildContext context,
    dynamic profileController,
  ) async {
    try {
      final success = await profileController.updateProfilePicture();

      if (success && context.mounted) {
        onSuccess?.call();

        // Mostrar mensaje por defecto si no hay callback personalizado
        if (onSuccess == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('¡Foto de perfil actualizada!')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        final errorMessage = 'Error al subir la imagen: $e';
        onError?.call(errorMessage);

        // Mostrar mensaje por defecto si no hay callback personalizado
        if (onError == null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(errorMessage)));
        }
      }
    }
  }
}
