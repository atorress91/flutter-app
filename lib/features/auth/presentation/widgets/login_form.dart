import 'package:flutter/material.dart';
import 'package:my_app/core/common/widgets/custom_text_field.dart';
import 'package:my_app/core/common/widgets/primary_button.dart';
import 'package:my_app/core/l10n/app_localizations.dart';

class LoginForm extends StatefulWidget {
  final Function(String username, String password) onSubmit;

  const LoginForm({super.key, required this.onSubmit});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _showPassword = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() == true) {
      setState(() => _isLoading = true);

      // Llamar a la función onSubmit pasada desde el parent
      widget.onSubmit(
        _usernameController.text.trim(),
        _passwordController.text,
      );

      // El estado de loading se manejará desde el parent/controller
      // pero lo reseteamos aquí por si hay error
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      });
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Campo de usuario
          CustomTextField(
            controller: _usernameController,
            labelText: AppLocalizations.of(context).usernameOrEmailLabel,
            icon: Icons.person_outline,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.none,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return AppLocalizations.of(context).usernameOrEmailRequired;
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          // Campo de contraseña
          CustomTextField(
            controller: _passwordController,
            labelText: AppLocalizations.of(context).passwordLabel,
            icon: Icons.lock_outline,
            obscureText: !_showPassword,
            textInputAction: TextInputAction.done,
            suffixIcon: IconButton(
              icon: Icon(
                _showPassword ? Icons.visibility_off : Icons.visibility,
                color: theme.colorScheme.onSurface.withAlpha(
                  (255 * 0.7).toInt(),
                ),
                size: 20,
              ),
              onPressed: _togglePasswordVisibility,
              tooltip: _showPassword
                  ? AppLocalizations.of(context).t('hidePassword')
                  : AppLocalizations.of(context).t('showPassword'),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context).passwordRequired;
              }
              if (value.length < 6) {
                return AppLocalizations.of(context).passwordTooShort;
              }
              return null;
            },
            onFieldSubmitted: (_) => _handleSubmit(),
          ),

          const SizedBox(height: 24),

          // Botón de iniciar sesión
          PrimaryButton(
            text: AppLocalizations.of(context).signInButtonLabel,
            isLoading: _isLoading,
            onPressed: _handleSubmit,
          ),

          const SizedBox(height: 12),

          // Link de "¿Olvidaste tu contraseña?"
          TextButton(
            onPressed: () {
              // TODO: Implementar recuperación de contraseña
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppLocalizations.of(context).t('forgotPasswordSoon'),
                  ),
                ),
              );
            },
            child: Text(
              AppLocalizations.of(context).t('forgotPassword'),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
