import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/l10n/app_localizations.dart';

import '../controllers/login_controller.dart';

class LoginForm extends ConsumerStatefulWidget {
  final void Function(String username, String password) onSubmit;

  const LoginForm({super.key, required this.onSubmit});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  void _handleSubmit() {
    if (_validateForm()) {
      // Entregar valores al padre
      widget.onSubmit(_userController.text, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final loginState = ref.watch(loginControllerProvider);
    final controller = ref.read(loginControllerProvider.notifier);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _userController,
            enabled: !loginState.isLoading,
            decoration: const InputDecoration(
              labelText: 'Usuario o email',
              prefixIcon: Icon(Icons.person_outline),
            ),
            textInputAction: TextInputAction.next,
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return 'Ingresa tu usuario o email';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _passwordController,
            enabled: !loginState.isLoading,
            decoration: InputDecoration(
              labelText: strings.passwordLabel,
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  loginState.obscurePassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: loginState.isLoading
                    ? null
                    : controller.togglePasswordVisibility,
              ),
            ),
            obscureText: loginState.obscurePassword,
            onFieldSubmitted: (_) => _handleSubmit(),
            validator: (v) {
              if (v == null || v.isEmpty) {
                return 'Ingresa tu contraseña';
              }
              if (v.length < 4) {
                return 'La contraseña es muy corta';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: loginState.isLoading ? null : _handleSubmit,
              child: loginState.isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(strings.signInButtonLabel),
            ),
          ),
          if (loginState.error != null) ...[
            const SizedBox(height: 12),
            Text(
              loginState.error!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  String get username => _userController.text;

  String get password => _passwordController.text;
}
