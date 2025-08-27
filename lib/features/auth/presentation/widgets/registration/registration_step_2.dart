import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/common/widgets/custom_text_field.dart';
import 'package:my_app/core/common/widgets/custom_dropdown.dart';
import 'package:my_app/core/common/widgets/step_navigation_buttons.dart';
import 'package:my_app/features/auth/presentation/screens/registration_screen.dart';

class RegistrationStep2 extends ConsumerStatefulWidget {
  const RegistrationStep2({super.key});

  @override
  ConsumerState<RegistrationStep2> createState() => _RegistrationStep2State();
}

class _RegistrationStep2State extends ConsumerState<RegistrationStep2> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedCountry;

  final List<String> _countries = [
    'Argentina',
    'Bolivia',
    'Chile',
    'Colombia',
    'Costa Rica',
    'Ecuador',
    'España',
    'México',
    'Perú',
    'Venezuela',
  ];

  @override
  void initState() {
    super.initState();
    final data = ref.read(registrationDataProvider);
    _firstNameController.text = data['firstName'] ?? '';
    _lastNameController.text = data['lastName'] ?? '';
    _phoneController.text = data['phoneNumber'] ?? '';
    _selectedCountry = data['country'];
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if ((_formKey.currentState?.validate() ?? false) &&
        _selectedCountry != null) {
      ref
          .read(registrationDataProvider.notifier)
          .update(
            (state) => {
              ...state,
              'firstName': _firstNameController.text,
              'lastName': _lastNameController.text,
              'phoneNumber': _phoneController.text,
              'country': _selectedCountry,
            },
          );
      ref.read(registrationStepProvider.notifier).state++;
    } else if (_selectedCountry == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Debes seleccionar un país'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  void _previousStep() {
    ref.read(registrationStepProvider.notifier).state--;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            controller: _firstNameController,
            labelText: 'Nombre',
            icon: Icons.badge_outlined,
            textCapitalization: TextCapitalization.words,
            validator: (v) => (v == null || v.trim().isEmpty)
                ? 'El nombre es requerido'
                : null,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _lastNameController,
            labelText: 'Apellido',
            icon: Icons.badge_outlined,
            textCapitalization: TextCapitalization.words,
            validator: (v) => (v == null || v.trim().isEmpty)
                ? 'El apellido es requerido'
                : null,
          ),
          const SizedBox(height: 16),
          CustomDropdown<String>(
            value: _selectedCountry,
            items: _countries,
            labelText: 'País',
            icon: Icons.public,
            onChanged: (value) => setState(() => _selectedCountry = value),
            itemLabel: (country) => country,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _phoneController,
            labelText: 'Número de teléfono',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: (v) => (v == null || v.trim().isEmpty)
                ? 'El teléfono es requerido'
                : null,
          ),
          const SizedBox(height: 24),
          StepNavigationButtons(
            onBack: _previousStep,
            onNext: _nextStep,
            showBack: true,
          ),
        ],
      ),
    );
  }
}
