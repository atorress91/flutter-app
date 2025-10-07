import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/common/widgets/error_display.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import 'package:my_app/core/providers/platform_providers.dart';
import 'package:my_app/core/theme/app_theme.dart';
import 'package:my_app/features/auth/presentation/controllers/login_controller.dart';
import 'package:my_app/features/auth/presentation/widgets/biometric_login_button.dart';
import 'package:my_app/features/auth/presentation/widgets/login_form.dart';

// Estado local para el mensaje de error del login
final loginErrorMessageProvider = StateProvider<String?>((ref) => null);

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final isTablet = mediaQuery.size.width > 600;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary.withAlpha((255 * 0.1).toInt()),
              theme.scaffoldBackgroundColor,
              theme.colorScheme.surface.withAlpha((255 * 0.95).toInt()),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isTablet ? 480 : 360,
                    ),
                    child: _buildLogoSection(context, theme),
                  ),
                ),
                const SizedBox(height: 32),
                // Authentication section - full width
                _buildAuthSection(context, ref, theme, strings),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection(BuildContext context, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Image.asset(
        AppTheme.getLogoPath(context),
        height: 120,
        fit: BoxFit.contain,
        semanticLabel: 'Recycoin',
      ),
    );
  }

  Widget _buildAuthSection(
      BuildContext context,
      WidgetRef ref,
      ThemeData theme,
      AppLocalizations strings,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withAlpha((255 * 0.1).toInt()),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withAlpha((255 * 0.1).toInt()),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            strings.loginScreenTitle,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          // Biometric login button
          BiometricLoginButton(ref: ref),
          const SizedBox(height: 24),
          // Divider
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: theme.colorScheme.outline.withAlpha((255 * 0.2).toInt()),
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  AppLocalizations.of(context).t('loginOrContinueWith'),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withAlpha((255 * 0.6).toInt()),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  color: theme.colorScheme.outline.withAlpha((255 * 0.2).toInt()),
                  thickness: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Login form
          LoginForm(
            key: const Key('login_form'),
            onSubmit: (username, password) =>
                _handleLogin(context, ref, username, password),
          ),
          const SizedBox(height: 16),
          // Error display
          ErrorDisplay(errorMessage: ref.watch(loginErrorMessageProvider)),
        ],
      ),
    );
  }


  Future<void> _handleLogin(
      BuildContext context,
      WidgetRef ref,
      String username,
      String password,
      ) async {
    // Limpiar el error anterior
    ref.read(loginErrorMessageProvider.notifier).state = null;

    final controller = ref.read(loginControllerProvider.notifier);
    final isAffiliate = await controller.login(username, password);

    if (!context.mounted) return;

    if (isAffiliate != null) {
      // Guardar el último rol para el inicio con huella
      final bio = ref.read(biometricServiceProvider);
      await bio.saveLastIsAffiliate(isAffiliate);

      // Guardar las credenciales para el login biométrico
      await bio.saveCredentials(username, password);

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
    } else {
      // Establecer mensaje de error si las credenciales son inválidas
      ref.read(loginErrorMessageProvider.notifier).state =
          AppLocalizations.of(context).t('invalidCredentials');
    }
  }

  Future<bool?> askEnableBiometrics(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          strings.enableBiometricsTitle,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          strings.enableBiometricsContent,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onSurface.withAlpha(
                (255 * 0.6).toInt(),
              ),
            ),
            child: Text(strings.cancelButtonLabel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(strings.enableButtonLabel),
          ),
        ],
      ),
    );
  }
}