import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/services/platform/biometric_service.dart';

class BiometricLoginButton extends StatelessWidget {
  final WidgetRef ref;

  const BiometricLoginButton({super.key, required this.ref});

  @override
  Widget build(BuildContext context) {
    final bio = ref.read(biometricServiceProvider);
    return FutureBuilder<bool>(
      future: _ready(bio),
      builder: (context, snapshot) {
        final ready = snapshot.data == true;
        if (!ready) return const SizedBox.shrink();
        return SizedBox(
          height: 44,
          child: OutlinedButton.icon(
            icon: const Icon(Icons.fingerprint),
            label: const Text('Iniciar sesión con huella'),
            onPressed: () => _onPressed(context, bio),
          ),
        );
      },
    );
  }

  Future<bool> _ready(BiometricService bio) async {
    final enabled = await bio.isEnabled();
    if (!enabled) return false;
    return await bio.isBiometricAvailable();
  }

  Future<void> _onPressed(BuildContext context, BiometricService bio) async {
    final ok = await bio.authenticate(reason: 'Autentícate con tu huella');
    if (!ok) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Autenticación cancelada o fallida.')),
      );
      return;
    }
    final last = await bio.getLastIsAffiliate();
    if (last == null) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No hay datos para usar huella. Inicia primero con tu contraseña.',
          ),
        ),
      );
      return;
    }
    final route = last ? '/dashboard' : '/admin/dashboard';
    if (!context.mounted) return;
    context.go(route);
  }
}

Future<bool?> askEnableBiometrics(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Activar inicio con huella'),
      content: const Text(
        'Tus credenciales fueron validadas. ¿Deseas activar el inicio de sesión con huella dactilar?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: const Text('Ahora no'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(ctx).pop(true),
          child: const Text('Activar'),
        ),
      ],
    ),
  );
}
