import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/common/widgets/error_display.dart';
import 'package:my_app/core/theme/app_theme.dart';
import 'package:my_app/features/auth/presentation/controllers/registration_controller.dart';
import 'package:my_app/features/auth/presentation/widgets/registration/registration_step_1.dart';
import 'package:my_app/features/auth/presentation/widgets/registration/registration_step_2.dart';
import 'package:my_app/features/auth/presentation/widgets/registration/registration_step_3.dart';

// Provider para manejar el paso actual del formulario
final registrationStepProvider = StateProvider.autoDispose<int>((ref) => 1);

// Provider para almacenar los datos del formulario entre pasos
final registrationDataProvider =
    StateProvider.autoDispose<Map<String, dynamic>>((ref) => {});

class RegistrationScreen extends ConsumerWidget {
  final String? referralUserName;

  const RegistrationScreen({super.key, this.referralUserName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(registrationStepProvider);
    final registrationState = ref.watch(registrationControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.scaffoldBackgroundColor,
              theme.colorScheme.surface,
              theme.colorScheme.surface.withAlpha((255 * 0.8).toInt()),
            ],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Card(
              elevation: 10,
              shadowColor: theme.shadowColor.withAlpha((255 * 0.5).toInt()),
              color: theme.cardColor.withAlpha((255 * 0.9).toInt()),
              margin: const EdgeInsets.all(24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Image.asset(
                          AppTheme.getLogoPath(context),
                          height: 64,
                          fit: BoxFit.contain,
                          semanticLabel: 'Recycoin',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Crear Cuenta',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      _buildStepIndicator(context, currentStep),
                      const SizedBox(height: 24),

                      // AnimatedSwitcher para transiciones suaves entre pasos
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0.5, 0),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            ),
                          );
                        },
                        child: _buildCurrentStep(currentStep, referralUserName),
                      ),

                      const SizedBox(height: 16),
                      // Error display general
                      ErrorDisplay(errorMessage: registrationState.error),
                      const SizedBox(height: 16),

                      // Link para ir al login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '¿Ya tienes cuenta?',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withAlpha(
                                (255 * 0.7).toInt(),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.go('/auth/login'),
                            child: const Text('Iniciar Sesión'),
                          ),
                        ],
                      ),

                      // Sección de Social Login
                      _buildSocialLogin(context),
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

  Widget _buildCurrentStep(int step, String? referralUserName) {
    switch (step) {
      case 1:
        return const RegistrationStep1(key: ValueKey('step1'));
      case 2:
        return const RegistrationStep2(key: ValueKey('step2'));
      case 3:
        return RegistrationStep3(
          key: const ValueKey('step3'),
          initialReferralUser: referralUserName,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStepIndicator(BuildContext context, int currentStep) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        bool isActive = (index + 1) == currentStep;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          height: 12,
          width: isActive ? 24 : 12,
          decoration: BoxDecoration(
            color: isActive
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface.withAlpha((255 * 0.3).toInt()),
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }),
    );
  }

  Widget _buildSocialLogin(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Divider(
                color: theme.colorScheme.onSurface.withAlpha(
                  (255 * 0.7).toInt(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'O regístrate con',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withAlpha(
                    (255 * 0.6).toInt(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: theme.colorScheme.onSurface.withAlpha(
                  (255 * 0.3).toInt(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                /* Lógica de Google Sign In */
              },
              style: OutlinedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
                side: BorderSide(color: theme.colorScheme.outline),
              ),
              child: Icon(
                Icons.g_mobiledata,
                color: theme.colorScheme.onSurface,
                size: 28,
              ), // Placeholder for Google Icon
            ),
            const SizedBox(width: 24),
            OutlinedButton(
              onPressed: () {
                /* Lógica de Apple Sign In */
              },
              style: OutlinedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
                side: BorderSide(color: theme.colorScheme.outline),
              ),
              child: Icon(
                Icons.apple,
                color: theme.colorScheme.onSurface,
                size: 28,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
