import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/common/widgets/custom_text_field.dart';
import 'package:my_app/core/common/widgets/step_navigation_buttons.dart';
import 'package:my_app/features/auth/presentation/controllers/registration_controller.dart';
import 'package:my_app/features/auth/presentation/screens/registration_screen.dart';

class RegistrationStep1 extends ConsumerStatefulWidget {
  const RegistrationStep1({super.key});

  @override
  ConsumerState<RegistrationStep1> createState() => _RegistrationStep1State();
}

class _RegistrationStep1State extends ConsumerState<RegistrationStep1> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final data = ref.read(registrationDataProvider);
    _userNameController.text = data['userName'] ?? '';
    _emailController.text = data['email'] ?? '';
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_formKey.currentState?.validate() ?? false) {
      ref
          .read(registrationDataProvider.notifier)
          .update(
            (state) => {
              ...state,
              'userName': _userNameController.text,
              'email': _emailController.text,
              'password': _passwordController.text,
              'confirmPassword': _confirmPasswordController.text,
            },
          );
      ref.read(registrationStepProvider.notifier).state++;
    }
  }

  Widget _buildPasswordVisibilityIcon(bool obscure, VoidCallback onPressed) {
    final theme = Theme.of(context);
    return IconButton(
      icon: Icon(
        obscure ? Icons.visibility : Icons.visibility_off,
        color: theme.colorScheme.onSurface.withAlpha((255 * 0.7).toInt()),
      ),
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    final registrationState = ref.watch(registrationControllerProvider);
    final notifier = ref.read(registrationControllerProvider.notifier);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            controller: _userNameController,
            labelText: 'Nombre de usuario',
            icon: Icons.person_outline,
            validator: (v) => (v == null || v.trim().length < 3)
                ? 'Mínimo 3 caracteres'
                : null,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _emailController,
            labelText: 'Correo electrónico',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (v) =>
                (v == null ||
                    !RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v))
                ? 'Correo inválido'
                : null,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _passwordController,
            labelText: 'Contraseña',
            icon: Icons.lock_outline,
            obscureText: registrationState.obscurePassword,
            suffixIcon: _buildPasswordVisibilityIcon(
              registrationState.obscurePassword,
              notifier.togglePasswordVisibility,
            ),
            validator: (v) =>
                (v == null || v.length < 6) ? 'Mínimo 6 caracteres' : null,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _confirmPasswordController,
            labelText: 'Confirmar contraseña',
            icon: Icons.lock_outline,
            obscureText: registrationState.obscureConfirmPassword,
            suffixIcon: _buildPasswordVisibilityIcon(
              registrationState.obscureConfirmPassword,
              notifier.toggleConfirmPasswordVisibility,
            ),
            validator: (v) => (v != _passwordController.text)
                ? 'Las contraseñas no coinciden'
                : null,
          ),
          const SizedBox(height: 24),
          StepNavigationButtons(onNext: _nextStep, showBack: false),
        ],
      ),
    );
  }
}
