import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/common/widgets/custom_text_field.dart';
import 'package:my_app/core/common/widgets/error_display.dart';
import 'package:my_app/core/common/widgets/primary_button.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import 'package:my_app/core/theme/app_theme.dart';
import 'package:my_app/features/auth/presentation/controllers/forgot_password_controller.dart';

// Estado local para el mensaje de error
final forgotPasswordErrorProvider = StateProvider<String?>((ref) => null);

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final isTablet = mediaQuery.size.width > 600;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.colorScheme.onSurface,
          ),
          onPressed: () => context.pop(),
        ),
      ),
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
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isTablet ? 480 : 360,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),
                      // Logo section
                      _buildLogoSection(context, theme),
                      const SizedBox(height: 32),
                      // Main content
                      _buildContentSection(context, theme, strings),
                      const SizedBox(height: 40),
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

  Widget _buildLogoSection(BuildContext context, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Image.asset(
        AppTheme.getLogoPath(context),
        height: 100,
        fit: BoxFit.contain,
        semanticLabel: 'Recycoin',
      ),
    );
  }

  Widget _buildContentSection(
    BuildContext context,
    ThemeData theme,
    AppLocalizations strings,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.outline.withAlpha((255 * 0.1).toInt()),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withAlpha((255 * 0.05).toInt()),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Icon
          Icon(
            Icons.lock_reset_rounded,
            size: 64,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 24),
          // Title
          Text(
            strings.t('forgotPasswordTitle'),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          // Description
          Text(
            strings.t('forgotPasswordDescription'),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withAlpha((255 * 0.7).toInt()),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          // Form
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextField(
                  controller: _emailController,
                  labelText: strings.t('emailLabel'),
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.email_outlined,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return strings.t('emailRequired');
                    }
                    // Validación básica de email
                    final emailRegex = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    );
                    if (!emailRegex.hasMatch(value.trim())) {
                      return strings.t('emailInvalid');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  text: strings.t('sendCodeButton'),
                  onPressed: _isLoading ? null : _handleSubmit,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Error display
          ErrorDisplay(errorMessage: ref.watch(forgotPasswordErrorProvider)),
        ],
      ),
    );
  }

  Future<void> _handleSubmit() async {
    // Limpiar error anterior
    ref.read(forgotPasswordErrorProvider.notifier).state = null;

    if (_formKey.currentState?.validate() != true) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final controller = ref.read(forgotPasswordControllerProvider.notifier);
      final success = await controller.sendPasswordResetCode(
        _emailController.text.trim(),
      );

      if (!mounted) return;

      if (success) {
        // Mostrar diálogo de éxito
        await _showSuccessDialog();
        if (!mounted) return;
        // Volver a la pantalla de login
        context.pop();
      } else {
        // Mostrar mensaje de error
        ref.read(forgotPasswordErrorProvider.notifier).state =
            AppLocalizations.of(context).t('forgotPasswordError');
      }
    } catch (e) {
      if (!mounted) return;
      ref.read(forgotPasswordErrorProvider.notifier).state =
          AppLocalizations.of(context).t('forgotPasswordError');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _showSuccessDialog() async {
    final strings = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: theme.colorScheme.primary,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                strings.t('forgotPasswordSuccessTitle'),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          strings.t('forgotPasswordSuccessMessage'),
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(strings.t('okButton')),
          ),
        ],
      ),
    );
  }
}
