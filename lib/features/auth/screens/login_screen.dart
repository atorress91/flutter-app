import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import 'package:my_app/core/providers/auth_providers.dart';
import 'package:my_app/core/data/request/request_user_auth.dart';
import 'package:my_app/core/services/device_info_service.dart';
import 'package:my_app/core/services/network_service.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final notifier = ref.read(authNotifierProvider.notifier);

    // Mostrar loading mientras recopilamos información del dispositivo
    setState(() {}); // Para mostrar el loading state

    try {
      // Recopilar información del dispositivo en paralelo
      final futures = await Future.wait([
        DeviceInfoService.getDeviceInfo(),
        NetworkService.getLocalIpAddress(),
      ]);

      final deviceInfo = futures[0] as Map<String, dynamic>;
      final ipAddress = futures[1] as String?;

      final browserInfo = DeviceInfoService.generateBrowserInfo(deviceInfo);
      final operatingSystem = DeviceInfoService.generateOperatingSystem(
        deviceInfo,
      );

      await notifier.login(
        RequestUserAuth(
          userName: _userController.text.trim(),
          password: _passwordController.text,
          browserInfo: browserInfo,
          ipAddress: ipAddress,
          operatingSystem: operatingSystem,
        ),
      );

      final session = ref.read(authNotifierProvider).value;
      final isAffiliate = session?.user.isAffiliate == 1;

      if (isAffiliate == true) {
        if (mounted) context.go('/dashboard');
      } else {
        if (mounted) context.go('/admin/dashboard');
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.isLoading;

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
              child: Form(
                key: _formKey,
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
                    TextFormField(
                      controller: _userController,
                      enabled: !isLoading,
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
                      enabled: !isLoading,
                      decoration: InputDecoration(
                        labelText: strings.passwordLabel,
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscure ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: isLoading
                              ? null
                              : () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                      obscureText: _obscure,
                      onFieldSubmitted: (_) => _submit(),
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
                        onPressed: isLoading ? null : _submit,
                        child: isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(strings.signInButtonLabel),
                      ),
                    ),
                    if (authState.hasError) ...[
                      const SizedBox(height: 12),
                      Text(
                        authState.error.toString(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
