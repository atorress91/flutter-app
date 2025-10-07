import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import 'package:my_app/core/providers/platform_providers.dart';
import 'package:my_app/core/services/platform/biometric_service.dart';
import 'package:my_app/features/auth/domain/use_cases/login_with_biometrics_use_case.dart';
import 'package:my_app/features/auth/presentation/controllers/login_controller.dart';

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
      // 1. Obtener las credenciales guardadas después de autenticar biométricamente
      final useCase = ref.read(loginWithBiometricsUseCaseProvider);
      final credentials = await useCase.execute();

      if (!context.mounted) return;

      // 2. Hacer el login usando el controller (que llama al backend)
      final controller = ref.read(loginControllerProvider.notifier);
      final isAffiliate = await controller.login(
        credentials['username']!,
        credentials['password']!,
      );

      if (!context.mounted) return;

      if (isAffiliate != null) {
        // Login exitoso, navegar a la ruta correspondiente
        final route = isAffiliate ? '/dashboard' : '/admin/dashboard';
        context.go(route);
      } else {
        // Si el login falla, mostrar error
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context).t('invalidCredentials'),
              ),
            ),
          );
      }
    } on AuthException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              'Error al iniciar sesión: ${e.toString()}',
            ),
          ),
        );
    }
  }
}
