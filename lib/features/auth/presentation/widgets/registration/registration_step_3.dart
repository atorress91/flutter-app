import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/common/widgets/custom_text_field.dart';
import 'package:my_app/core/common/widgets/step_navigation_buttons.dart';
import 'package:my_app/features/auth/presentation/controllers/registration_controller.dart';
import 'package:my_app/features/auth/presentation/screens/registration_screen.dart';

class RegistrationStep3 extends ConsumerStatefulWidget {
  final String? initialReferralUser;

  const RegistrationStep3({super.key, this.initialReferralUser});

  @override
  ConsumerState<RegistrationStep3> createState() => _RegistrationStep3State();
}

class _RegistrationStep3State extends ConsumerState<RegistrationStep3> {
  final _referralController = TextEditingController();
  bool _acceptedTerms = false;

  @override
  void initState() {
    super.initState();
    _referralController.text = widget.initialReferralUser ?? '';
    _acceptedTerms =
        ref.read(registrationDataProvider)['acceptedTerms'] ?? false;
  }

  @override
  void dispose() {
    _referralController.dispose();
    super.dispose();
  }

  void _previousStep() {
    ref.read(registrationStepProvider.notifier).state--;
  }

  Future<void> _submitRegistration() async {
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Debes aceptar los términos y condiciones'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    final data = ref.read(registrationDataProvider);
    final controller = ref.read(registrationControllerProvider.notifier);

    final success = await controller.register(
      userName: data['userName'],
      password: data['password'],
      confirmPassword: data['confirmPassword'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      country: data['country'],
      phoneNumber: data['phoneNumber'],
      email: data['email'],
      acceptedTerms: _acceptedTerms,
      referralUserName: _referralController.text.isNotEmpty
          ? _referralController.text
          : null,
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Cuenta creada exitosamente!'),
          backgroundColor: Colors.green,
        ),
      );
      context.go('/auth/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final registrationState = ref.watch(registrationControllerProvider);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextField(
          controller: _referralController,
          labelText: 'Usuario referidor (opcional)',
          icon: Icons.person_add_alt_1_outlined,
        ),
        const SizedBox(height: 16),
        CheckboxListTile(
          value: _acceptedTerms,
          onChanged: (value) => setState(() => _acceptedTerms = value ?? false),
          title: Text(
            'Acepto los términos y condiciones',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withAlpha((255 * 0.7).toInt()),
            ),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          activeColor: theme.colorScheme.primary,
          checkColor: theme.colorScheme.onPrimary,
        ),
        const SizedBox(height: 24),
        StepNavigationButtons(
          onBack: _previousStep,
          onNext: _submitRegistration,
          nextText: 'Registrarse',
          isLoading: registrationState.isLoading,
          showBack: true,
        ),
      ],
    );
  }
}
