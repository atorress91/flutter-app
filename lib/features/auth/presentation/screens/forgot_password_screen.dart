import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/common/widgets/custom_text_field.dart';
import 'package:my_app/core/common/widgets/error_display.dart';
import 'package:my_app/core/common/widgets/primary_button.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import 'package:my_app/core/theme/app_theme.dart';
import 'package:my_app/features/auth/presentation/controllers/forgot_password_controller.dart';
import 'dart:ui';

// Estado local para el mensaje de error
final forgotPasswordErrorProvider = StateProvider<String?>((ref) => null);

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    // Calcular el alto disponible real
    final availableHeight = screenHeight -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom -
        mediaQuery.viewInsets.bottom;

    // Definir breakpoints basados en altura disponible
    final isTablet = screenWidth >= 600;
    final isVerySmall = availableHeight < 600;
    final isSmall = availableHeight < 700 && !isVerySmall;

    // Calcular espaciados dinámicos
    final horizontalPadding = isTablet ? 48.0 : 24.0;
    final verticalPadding = isTablet ? 24.0 : (isVerySmall ? 16.0 : (isSmall ? 20.0 : 24.0));
    final logoHeight = isTablet ? 90.0 : (isVerySmall ? 45.0 : (isSmall ? 60.0 : 75.0));
    final logoSpacing = isTablet ? 32.0 : (isVerySmall ? 16.0 : (isSmall ? 20.0 : 28.0));

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Fondo con gradiente
          _buildAnimatedBackground(theme),
          // Contenido principal
          SafeArea(
            child: Column(
              children: [
                // AppBar personalizado
                _buildCustomAppBar(context, theme, isVerySmall),
                // Contenido scrolleable
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: IntrinsicHeight(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding,
                                vertical: verticalPadding,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Espaciador superior
                                  if (!isVerySmall) const Spacer(flex: 1),
                                  if (isVerySmall) const SizedBox(height: 8),

                                  // Logo con animación
                                  FadeTransition(
                                    opacity: _fadeAnimation,
                                    child: _buildLogoSection(
                                      context,
                                      theme,
                                      logoHeight,
                                    ),
                                  ),

                                  SizedBox(height: logoSpacing),

                                  // Card con glassmorphism
                                  SlideTransition(
                                    position: _slideAnimation,
                                    child: FadeTransition(
                                      opacity: _fadeAnimation,
                                      child: _buildGlassCard(
                                        context,
                                        theme,
                                        strings,
                                        isTablet,
                                        isVerySmall,
                                        isSmall,
                                      ),
                                    ),
                                  ),

                                  // Espaciador inferior
                                  if (!isVerySmall) const Spacer(flex: 2),
                                  if (isVerySmall) const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground(ThemeData theme) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: theme.brightness == Brightness.dark
                  ? [
                      const Color(0xFF0F0F1E),
                      const Color(0xFF1A1A2E),
                      const Color(0xFF16213E),
                    ]
                  : [
                      const Color(0xFFF5F7FA),
                      Colors.white,
                      const Color(0xFFE8F5E9),
                    ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCustomAppBar(BuildContext context, ThemeData theme, bool isVerySmall) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: isVerySmall ? 4 : 8,
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: theme.colorScheme.onSurface,
              size: isVerySmall ? 22 : 24,
            ),
            onPressed: () => context.pop(),
            tooltip: 'Volver',
          ),
        ],
      ),
    );
  }

  Widget _buildLogoSection(
    BuildContext context,
    ThemeData theme,
    double height,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.1),
            theme.colorScheme.primary.withValues(alpha: 0.0),
          ],
        ),
      ),
      child: Image.asset(
        AppTheme.getLogoPath(context),
        height: height,
        fit: BoxFit.contain,
        semanticLabel: 'Recycoin',
      ),
    );
  }

  Widget _buildGlassCard(
    BuildContext context,
    ThemeData theme,
    AppLocalizations strings,
    bool isTablet,
    bool isVerySmall,
    bool isSmall,
  ) {
    final cardPadding = isTablet ? 40.0 : (isVerySmall ? 20.0 : (isSmall ? 24.0 : 32.0));
    final iconSize = isTablet ? 64.0 : (isVerySmall ? 40.0 : (isSmall ? 48.0 : 56.0));
    final titleSize = isTablet ? 26.0 : (isVerySmall ? 18.0 : (isSmall ? 20.0 : 22.0));
    final descriptionSize = isTablet ? 15.0 : (isVerySmall ? 12.0 : (isSmall ? 13.0 : 14.0));
    final sectionSpacing = isTablet ? 24.0 : (isVerySmall ? 12.0 : (isSmall ? 16.0 : 20.0));
    final iconSpacing = isTablet ? 24.0 : (isVerySmall ? 12.0 : (isSmall ? 16.0 : 20.0));
    final titleSpacing = isTablet ? 12.0 : (isVerySmall ? 6.0 : (isSmall ? 8.0 : 12.0));

    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: isTablet ? 500 : double.infinity,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isVerySmall ? 24 : 32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: theme.brightness == Brightness.dark
                      ? [
                          Colors.white.withValues(alpha: 0.08),
                          Colors.white.withValues(alpha: 0.04),
                        ]
                      : [
                          Colors.white.withValues(alpha: 0.9),
                          Colors.white.withValues(alpha: 0.7),
                        ],
                ),
                borderRadius: BorderRadius.circular(isVerySmall ? 24 : 32),
                border: Border.all(
                  color: theme.brightness == Brightness.dark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.white.withValues(alpha: 0.5),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withValues(alpha: 0.1),
                    blurRadius: 40,
                    spreadRadius: 0,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              padding: EdgeInsets.all(cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Ícono
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(isVerySmall ? 12 : 16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.primary.withValues(alpha: 0.15),
                            theme.colorScheme.primary.withValues(alpha: 0.05),
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.lock_reset_rounded,
                        size: iconSize,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),

                  SizedBox(height: iconSpacing),

                  // Título
                  Text(
                    strings.t('forgotPasswordTitle'),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                      fontSize: titleSize,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: titleSpacing),

                  // Descripción
                  Text(
                    strings.t('forgotPasswordDescription'),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      fontSize: descriptionSize,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: sectionSpacing),

                  // Formulario
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
                          isCompact: isVerySmall,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _handleSubmit(),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return strings.t('emailRequired');
                            }
                            final emailRegex = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                            );
                            if (!emailRegex.hasMatch(value.trim())) {
                              return strings.t('emailInvalid');
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: sectionSpacing),

                        PrimaryButton(
                          text: strings.t('sendLinkButton'),
                          onPressed: _isLoading ? null : _handleSubmit,
                          isLoading: _isLoading,
                          height: isVerySmall ? 48 : 56,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: isVerySmall ? 8 : 16),

                  // Error display
                  ErrorDisplay(
                    errorMessage: ref.watch(forgotPasswordErrorProvider),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
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
        await _showSuccessDialog();
        if (!mounted) return;
        context.pop();
      } else {
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
    final screenWidth = mediaQuery.size.width;
    final availableHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;

    final isVerySmall = availableHeight < 600;
    final isSmall = screenWidth < 360;

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        contentPadding: EdgeInsets.all(isSmall ? 20 : 24),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(isSmall ? 6 : 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.check_circle,
                color: theme.colorScheme.primary,
                size: isSmall ? 24 : 28,
              ),
            ),
            SizedBox(width: isSmall ? 10 : 12),
            Expanded(
              child: Text(
                strings.t('forgotPasswordSuccessTitle'),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: isSmall ? 18 : 20,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          strings.t('forgotPasswordSuccessMessage'),
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: isSmall ? 13 : 14,
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
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: isVerySmall ? 12 : 16,
                ),
              ),
              child: Text(
                strings.t('okButton'),
                style: TextStyle(
                  fontSize: isSmall ? 14 : 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
