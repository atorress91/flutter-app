import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import 'package:my_app/core/services/platform/biometric_service.dart';
import 'package:my_app/features/auth/presentation/controllers/login_controller.dart';
import 'package:my_app/features/auth/presentation/widgets/biometric_login_button.dart';
import 'package:my_app/features/auth/presentation/widgets/login_form.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F0F1F), Color(0xFF1A1A2E), Color(0xFF22344D)],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Card(
              elevation: 10,
              shadowColor: Colors.black54,
              margin: const EdgeInsets.all(24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Recycoin banner logo
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Image.asset(
                          'assets/images/recycoin-banner.png',
                          height: 64,
                          fit: BoxFit.contain,
                          semanticLabel: 'Recycoin',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        strings.loginScreenTitle,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      // Botón para iniciar sesión con huella si está habilitado y disponible
                      BiometricLoginButton(ref: ref),
                      const SizedBox(height: 12),
                      LoginForm(
                        key: const Key('login_form'),
                        // Pasar las credenciales desde el formulario
                        onSubmit: (username, password) =>
                            _handleLogin(context, ref, username, password),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin(
    BuildContext context,
    WidgetRef ref,
    String username,
    String password,
  ) async {
    final controller = ref.read(loginControllerProvider.notifier);
    final isAffiliate = await controller.login(username, password);

    if (!context.mounted) return;

    if (isAffiliate != null) {
      // Guardar el último rol para el inicio con huella
      final bio = ref.read(biometricServiceProvider);
      await bio.saveLastIsAffiliate(isAffiliate);

      // Si la biometría no está habilitada pero está disponible,
      // preguntar al usuario si desea activarla.
      final enabled = await bio.isEnabled();
      if (!enabled) {
        final available = await bio.isBiometricAvailable();
        if (available) {
          if (!context.mounted) return;

          final shouldEnable = await askEnableBiometrics(context);
          if (shouldEnable == true) {
            await bio.setEnabled(true);
          }
        }
      }

      if (!context.mounted) return;

      final route = isAffiliate ? '/dashboard' : '/admin/dashboard';
      context.go(route);
    }
  }

  Future<bool?> askEnableBiometrics(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(strings.enableBiometricsTitle),
        content: Text(strings.enableBiometricsContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(strings.cancelButtonLabel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(strings.enableButtonLabel),
          ),
        ],
      ),
    );
  }
}
