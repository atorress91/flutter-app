import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import 'package:my_app/core/providers/platform_providers.dart';
import 'package:my_app/core/services/platform/biometric_service.dart';
import 'package:my_app/features/auth/domain/use_cases/login_with_biometrics_use_case.dart';

import 'package:my_app/features/auth/presentation/providers/auth_state_provider.dart';

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
            label: Text(AppLocalizations.of(context).t('signInWithBiometrics')),
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
      final useCase = ref.read(loginWithBiometricsUseCaseProvider);
      final route = await useCase.execute();

      // Verificar que el widget sigue montado antes de continuar
      if (!context.mounted) return;

      // Se añade esta línea para recargar la sesión desde el almacenamiento.
      await ref.read(authNotifierProvider.notifier).refreshUserData();
      // Verificar nuevamente después de la segunda operación async
      if (!context.mounted) return;

      context.go(route);
    } on AuthException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
