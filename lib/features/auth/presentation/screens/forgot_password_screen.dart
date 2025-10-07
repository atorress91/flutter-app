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
    final screenWidth = mediaQuery.size.width;

    // Definir breakpoints responsivos
    final isSmallMobile = screenWidth < 360;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 900;
    final isLargeTablet = screenWidth >= 900;

    // Ajustar tamaños según el dispositivo
    final horizontalPadding = isSmallMobile ? 16.0 : (isMobile ? 20.0 : (isTablet ? 32.0 : 40.0));
    final maxWidth = isLargeTablet ? 520.0 : (isTablet ? 480.0 : (isMobile ? double.infinity : 360.0));
    final logoHeight = isSmallMobile ? 70.0 : (isMobile ? 80.0 : (isTablet ? 100.0 : 120.0));
    final topSpacing = isSmallMobile ? 20.0 : (isMobile ? 32.0 : (isTablet ? 48.0 : 60.0));
    final bottomSpacing = isSmallMobile ? 20.0 : (isMobile ? 32.0 : 40.0);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.colorScheme.onSurface,
            size: isMobile ? 24 : 28,
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
                maxWidth: maxWidth,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: topSpacing),
                      // Logo section
                      _buildLogoSection(context, theme, logoHeight),
                      SizedBox(height: isMobile ? 24 : 32),
                      // Main content
                      _buildContentSection(
                        context,
                        theme,
                        strings,
                        isSmallMobile,
                        isMobile,
                        isTablet,
                      ),
                      SizedBox(height: bottomSpacing),
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

  Widget _buildLogoSection(BuildContext context, ThemeData theme, double height) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Image.asset(
        AppTheme.getLogoPath(context),
        height: height,
        fit: BoxFit.contain,
        semanticLabel: 'Recycoin',
      ),
    );
  }

  Widget _buildContentSection(
    BuildContext context,
    ThemeData theme,
    AppLocalizations strings,
    bool isSmallMobile,
    bool isMobile,
    bool isTablet,
  ) {
    // Ajustar padding del contenedor según el dispositivo
    final containerPadding = isSmallMobile ? 16.0 : (isMobile ? 20.0 : 24.0);
    final iconSize = isSmallMobile ? 48.0 : (isMobile ? 56.0 : 64.0);
    final borderRadius = isSmallMobile ? 16.0 : (isMobile ? 20.0 : 24.0);

    return Container(
      padding: EdgeInsets.all(containerPadding),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: theme.colorScheme.outline.withAlpha((255 * 0.1).toInt()),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withAlpha((255 * 0.05).toInt()),
            blurRadius: isTablet ? 30 : 20,
            offset: Offset(0, isTablet ? 15 : 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Icon
          Icon(
            Icons.lock_reset_rounded,
            size: iconSize,
            color: theme.colorScheme.primary,
          ),
          SizedBox(height: isSmallMobile ? 16 : (isMobile ? 20 : 24)),
          // Title
          Text(
            strings.t('forgotPasswordTitle'),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
              fontSize: isSmallMobile ? 20 : (isMobile ? 22 : (isTablet ? 24 : 26)),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isSmallMobile ? 8 : 12),
          // Description
          Text(
            strings.t('forgotPasswordDescription'),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withAlpha((255 * 0.7).toInt()),
              fontSize: isSmallMobile ? 13 : (isMobile ? 14 : 15),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isSmallMobile ? 24 : (isMobile ? 28 : 32)),
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
                SizedBox(height: isSmallMobile ? 20 : 24),
                PrimaryButton(
                  text: strings.t('sendLinkButton'),
                  onPressed: _isLoading ? null : _handleSubmit,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
          SizedBox(height: isSmallMobile ? 12 : 16),
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
    final mediaQuery = MediaQuery.of(context);
    final isMobile = mediaQuery.size.width < 600;
    final isSmallMobile = mediaQuery.size.width < 360;

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isSmallMobile ? 12 : 16),
        ),
        contentPadding: EdgeInsets.all(isSmallMobile ? 16 : (isMobile ? 20 : 24)),
        title: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: theme.colorScheme.primary,
              size: isSmallMobile ? 24 : 28,
            ),
            SizedBox(width: isSmallMobile ? 8 : 12),
            Expanded(
              child: Text(
                strings.t('forgotPasswordSuccessTitle'),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: isSmallMobile ? 18 : (isMobile ? 20 : 22),
                ),
              ),
            ),
          ],
        ),
        content: Text(
          strings.t('forgotPasswordSuccessMessage'),
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: isSmallMobile ? 13 : 14,
            height: 1.5,
          ),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: isSmallMobile ? 12 : 16,
                ),
              ),
              child: Text(
                strings.t('okButton'),
                style: TextStyle(
                  fontSize: isSmallMobile ? 14 : 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
