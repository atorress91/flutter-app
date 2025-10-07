import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/common/widgets/error_display.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import 'package:my_app/core/providers/platform_providers.dart';
import 'package:my_app/core/services/platform/biometric_service.dart';
import 'package:my_app/core/theme/app_theme.dart';
import 'package:my_app/features/auth/domain/use_cases/login_with_biometrics_use_case.dart';
import 'package:my_app/features/auth/presentation/controllers/login_controller.dart';
import 'package:my_app/features/auth/presentation/widgets/login_form.dart';
import 'dart:ui';

// Estado local para el mensaje de error del login
final loginErrorMessageProvider = StateProvider<String?>((ref) => null);

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
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

    // Definir breakpoints más granulares
    final isTablet = screenWidth >= 600;
    final isVerySmall = availableHeight < 600;
    final isSmall = availableHeight < 700 && !isVerySmall;

    // Calcular espaciados dinámicos basados en altura disponible
    final verticalPadding = isTablet ? 48.0 : (isVerySmall ? 16.0 : (isSmall ? 20.0 : 32.0));
    final horizontalPadding = isTablet ? 48.0 : 24.0;
    final logoSpacing = isTablet ? 48.0 : (isVerySmall ? 20.0 : (isSmall ? 28.0 : 40.0));

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Fondo con gradiente animado
          _buildAnimatedBackground(theme),
          // Burbujas decorativas flotantes (solo en pantallas grandes)
          if (!isVerySmall) _buildFloatingBubbles(theme),
          // Contenido principal
          SafeArea(
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
                            // Espaciador superior flexible
                            if (!isVerySmall) const Spacer(flex: 1),
                            if (isVerySmall) const SizedBox(height: 8),

                            // Logo con animación
                            FadeTransition(
                              opacity: _fadeAnimation,
                              child: _buildLogoSection(
                                context,
                                theme,
                                isTablet,
                                isVerySmall,
                                isSmall,
                                availableHeight,
                              ),
                            ),

                            SizedBox(height: logoSpacing),

                            // Card de autenticación con glassmorphism
                            SlideTransition(
                              position: _slideAnimation,
                              child: FadeTransition(
                                opacity: _fadeAnimation,
                                child: _buildGlassCard(
                                  context,
                                  ref,
                                  theme,
                                  strings,
                                  isTablet,
                                  isVerySmall,
                                  isSmall,
                                ),
                              ),
                            ),

                            // Espaciador inferior flexible
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

  Widget _buildFloatingBubbles(ThemeData theme) {
    return Stack(
      children: [
        Positioned(
          top: 100,
          right: -50,
          child: _buildBubble(200, theme.colorScheme.primary.withOpacity(0.05)),
        ),
        Positioned(
          top: 300,
          left: -30,
          child: _buildBubble(150, theme.colorScheme.primary.withOpacity(0.08)),
        ),
        Positioned(
          bottom: 150,
          right: 50,
          child: _buildBubble(120, theme.colorScheme.primary.withOpacity(0.06)),
        ),
        Positioned(
          bottom: -40,
          left: 80,
          child: _buildBubble(180, theme.colorScheme.primary.withOpacity(0.04)),
        ),
      ],
    );
  }

  Widget _buildBubble(double size, Color color) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(seconds: 3),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (0.5 - (value % 1))),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogoSection(
    BuildContext context,
    ThemeData theme,
    bool isTablet,
    bool isVerySmall,
    bool isSmall,
    double availableHeight,
  ) {
    // Calcular tamaño del logo dinámicamente
    final logoHeight = isTablet
        ? 100.0
        : (isVerySmall ? 50.0 : (isSmall ? 65.0 : 85.0));

    final titleSize = isTablet ? null : (isVerySmall ? 20.0 : (isSmall ? 24.0 : null));
    final subtitleSize = isVerySmall ? 12.0 : (isSmall ? 13.0 : null);
    final showSubtitle = !isVerySmall;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(isVerySmall ? 12 : 20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                theme.colorScheme.primary.withOpacity(0.1),
                theme.colorScheme.primary.withOpacity(0.0),
              ],
            ),
          ),
          child: Image.asset(
            AppTheme.getLogoPath(context),
            height: logoHeight,
            fit: BoxFit.contain,
            semanticLabel: 'Recycoin',
          ),
        ),
        SizedBox(height: isVerySmall ? 8 : 16),
        Text(
          'Recycoin',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: theme.colorScheme.primary,
            fontSize: titleSize,
          ),
        ),
        if (showSubtitle) ...[
          SizedBox(height: isVerySmall ? 4 : 8),
          Text(
            AppLocalizations.of(context).t('welcomeBack') ?? 'Bienvenido de nuevo',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              fontWeight: FontWeight.w300,
              fontSize: subtitleSize,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildGlassCard(
    BuildContext context,
    WidgetRef ref,
    ThemeData theme,
    AppLocalizations strings,
    bool isTablet,
    bool isVerySmall,
    bool isSmall,
  ) {
    final cardPadding = isTablet ? 40.0 : (isVerySmall ? 20.0 : (isSmall ? 24.0 : 32.0));
    final titleSize = isTablet ? 28.0 : (isVerySmall ? 18.0 : (isSmall ? 20.0 : 24.0));
    final sectionSpacing = isTablet ? 24.0 : (isVerySmall ? 12.0 : (isSmall ? 16.0 : 20.0));

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
                          Colors.white.withOpacity(0.08),
                          Colors.white.withOpacity(0.04),
                        ]
                      : [
                          Colors.white.withOpacity(0.9),
                          Colors.white.withOpacity(0.7),
                        ],
                ),
                borderRadius: BorderRadius.circular(isVerySmall ? 24 : 32),
                border: Border.all(
                  color: theme.brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.white.withOpacity(0.5),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withOpacity(0.1),
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
                  // Título
                  Text(
                    strings.loginScreenTitle,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                      fontSize: titleSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: sectionSpacing),

                  // Botón biométrico mejorado
                  _buildEnhancedBiometricButton(ref, theme, isVerySmall),

                  SizedBox(height: sectionSpacing),

                  // Divider elegante
                  _buildElegantDivider(context, theme, isVerySmall),

                  SizedBox(height: sectionSpacing),

                  // Formulario de login
                  LoginForm(
                    key: const Key('login_form'),
                    onSubmit: (username, password) =>
                        _handleLogin(context, ref, username, password),
                  ),

                  SizedBox(height: isVerySmall ? 8 : 16),

                  // Error display
                  ErrorDisplay(errorMessage: ref.watch(loginErrorMessageProvider)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedBiometricButton(WidgetRef ref, ThemeData theme, bool isVerySmall) {
    final bio = ref.read(biometricServiceProvider);

    return FutureBuilder<bool>(
      future: _isReady(bio),
      builder: (context, snapshot) {
        if (snapshot.data != true) return const SizedBox.shrink();

        return Container(
          height: isVerySmall ? 44 : 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary.withOpacity(0.15),
                theme.colorScheme.primary.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(isVerySmall ? 12 : 16),
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _onBiometricPressed(context, ref),
              borderRadius: BorderRadius.circular(isVerySmall ? 12 : 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fingerprint,
                    color: theme.colorScheme.primary,
                    size: isVerySmall ? 20 : 28,
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      AppLocalizations.of(context).t('signInWithBiometrics'),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: isVerySmall ? 13 : 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildElegantDivider(BuildContext context, ThemeData theme, bool isVerySmall) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  theme.colorScheme.outline.withOpacity(0.3),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isVerySmall ? 12 : 16),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isVerySmall ? 8 : 12,
              vertical: isVerySmall ? 2 : 4,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              AppLocalizations.of(context).t('loginOrContinueWith'),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
                fontWeight: FontWeight.w500,
                fontSize: isVerySmall ? 10 : 12,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.outline.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<bool> _isReady(BiometricService bio) async {
    final enabled = await bio.isEnabled();
    if (!enabled) return false;
    return await bio.isBiometricAvailable();
  }

  Future<void> _onBiometricPressed(BuildContext context, WidgetRef ref) async {
    try {
      final useCase = ref.read(loginWithBiometricsUseCaseProvider);
      final credentials = await useCase.execute();

      if (!context.mounted) return;

      final controller = ref.read(loginControllerProvider.notifier);
      final isAffiliate = await controller.login(
        credentials['username']!,
        credentials['password']!,
      );

      if (!context.mounted) return;

      if (isAffiliate != null) {
        final route = isAffiliate ? '/dashboard' : '/admin/dashboard';
        context.go(route);
      } else {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context).t('invalidCredentials'),
              ),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
    }
  }

  Future<void> _handleLogin(
    BuildContext context,
    WidgetRef ref,
    String username,
    String password,
  ) async {
    ref.read(loginErrorMessageProvider.notifier).state = null;

    final controller = ref.read(loginControllerProvider.notifier);
    final isAffiliate = await controller.login(username, password);

    if (!context.mounted) return;

    if (isAffiliate != null) {
      final bio = ref.read(biometricServiceProvider);
      await bio.saveLastIsAffiliate(isAffiliate);
      await bio.saveCredentials(username, password);

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
      ref.read(loginErrorMessageProvider.notifier).state =
          AppLocalizations.of(context).t('invalidCredentials');
    }
  }

  Future<bool?> askEnableBiometrics(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.fingerprint,
                color: theme.colorScheme.primary,
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                strings.enableBiometricsTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          strings.enableBiometricsContent,
          style: theme.textTheme.bodyMedium?.copyWith(
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: TextButton.styleFrom(
              foregroundColor: theme.colorScheme.onSurface.withOpacity(0.6),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: Text(strings.cancelButtonLabel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(strings.enableButtonLabel),
          ),
        ],
      ),
    );
  }
}
