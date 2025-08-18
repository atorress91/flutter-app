import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import '../presentation/controllers/login_controller.dart';
import '../presentation/widgets/login_form.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Card(
            elevation: 6,
            margin: const EdgeInsets.all(24),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    strings.loginScreenTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
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
    );
  }

  Future<void> _handleLogin(
    BuildContext context,
    WidgetRef ref,
    String username,
    String password,
  ) async {
    final controller = ref.read(loginControllerProvider.notifier);
    final result = await controller.login(username, password);

    if (!context.mounted) return;

    if (result.success) {
      final isAffiliate = result.data;
      print(isAffiliate);
      final route = isAffiliate ? '/dashboard' : '/admin/dashboard';
      context.go(route);
    }
  }
}
