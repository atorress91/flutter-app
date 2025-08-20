import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/errors/exceptions.dart';
import '../../../../core/services/platform/biometric_service.dart';
import '../../domain/use_cases/login_with_biometrics_use_case.dart';

class BiometricLoginButton extends ConsumerWidget {
  const BiometricLoginButton({super.key, required WidgetRef ref});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bio = ref.read(biometricServiceProvider);
    return FutureBuilder<bool>(
      future: _isReady(bio),
      builder: (context, snapshot) {
        if (snapshot.data != true) return const SizedBox.shrink();

        return SizedBox(
          height: 44,
          child: OutlinedButton.icon(
            icon: const Icon(Icons.fingerprint),
            label: const Text('Iniciar sesión con huella'),
            onPressed: () => _onPressed(context, ref),
          ),
        );
      },
    );
  }

  Future<bool> _isReady(BiometricService bio) async {
    final enabled = await bio.isEnabled();
    if (!enabled) return false;
    return await bio.isBiometricAvailable();
  }

  Future<void> _onPressed(BuildContext context, WidgetRef ref) async {
    try {
      // 1. Llama al Caso de Uso.
      final useCase = ref.read(loginWithBiometricsUseCaseProvider);
      final route = await useCase.execute();

      if (!context.mounted) return;
      // 2. Si tiene éxito, navega.
      context.go(route);
    } on AuthException catch (e) {
      if (!context.mounted) return;
      // 3. Si falla, muestra el error.
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
