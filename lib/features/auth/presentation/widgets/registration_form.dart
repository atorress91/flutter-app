import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/features/auth/presentation/controllers/registration_controller.dart';
import 'package:my_app/features/auth/presentation/screens/registration_screen.dart';

// Decoración personalizada para todos los campos de texto
InputDecoration customInputDecoration({
  required String labelText,
  required IconData icon,
  required BuildContext context,
  Widget? suffixIcon,
}) {
  final theme = Theme.of(context);

  return InputDecoration(
    labelText: labelText,
    labelStyle: theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurface.withAlpha((255 * 0.7).toInt()),
    ),
    prefixIcon: Icon(
      icon,
      color: theme.colorScheme.onSurface.withAlpha((255 * 0.7).toInt()),
      size: 20,
    ),
    suffixIcon: suffixIcon,
    filled: true,
    fillColor: theme.colorScheme.surface.withAlpha((255 * 0.2).toInt()),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(color: theme.colorScheme.error, width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
    ),
  );
}

// Botón de acción principal
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: theme.colorScheme.onPrimary,
                ),
              )
            : Text(text),
      ),
    );
  }
}

// --- PASO 1: CREDENCIALES ---

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

  @override
  Widget build(BuildContext context) {
    final registrationState = ref.watch(registrationControllerProvider);
    final notifier = ref.read(registrationControllerProvider.notifier);
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _userNameController,
            style: theme.textTheme.bodyLarge,
            decoration: customInputDecoration(
              labelText: 'Nombre de usuario',
              icon: Icons.person_outline,
              context: context,
            ),
            validator: (v) => (v == null || v.trim().length < 3)
                ? 'Mínimo 3 caracteres'
                : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            style: theme.textTheme.bodyLarge,
            keyboardType: TextInputType.emailAddress,
            decoration: customInputDecoration(
              labelText: 'Correo electrónico',
              icon: Icons.email_outlined,
              context: context,
            ),
            validator: (v) =>
                (v == null ||
                    !RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v))
                ? 'Correo inválido'
                : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: registrationState.obscurePassword,
            style: theme.textTheme.bodyLarge,
            decoration: customInputDecoration(
              labelText: 'Contraseña',
              icon: Icons.lock_outline,
              context: context,
              suffixIcon: IconButton(
                icon: Icon(
                  registrationState.obscurePassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: theme.colorScheme.onSurface.withAlpha(
                    (255 * 0.7).toInt(),
                  ),
                ),
                onPressed: notifier.togglePasswordVisibility,
              ),
            ),
            validator: (v) =>
                (v == null || v.length < 6) ? 'Mínimo 6 caracteres' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: registrationState.obscureConfirmPassword,
            style: theme.textTheme.bodyLarge,
            decoration: customInputDecoration(
              labelText: 'Confirmar contraseña',
              icon: Icons.lock_outline,
              context: context,
              suffixIcon: IconButton(
                icon: Icon(
                  registrationState.obscureConfirmPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: theme.colorScheme.onSurface.withAlpha(
                    (255 * 0.7).toInt(),
                  ),
                ),
                onPressed: notifier.toggleConfirmPasswordVisibility,
              ),
            ),
            validator: (v) => (v != _passwordController.text)
                ? 'Las contraseñas no coinciden'
                : null,
          ),
          const SizedBox(height: 24),
          PrimaryButton(text: 'Siguiente', onPressed: _nextStep),
        ],
      ),
    );
  }
}

// --- PASO 2: INFORMACIÓN PERSONAL ---

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _firstNameController,
            style: theme.textTheme.bodyLarge,
            textCapitalization: TextCapitalization.words,
            decoration: customInputDecoration(
              labelText: 'Nombre',
              icon: Icons.badge_outlined,
              context: context,
            ),
            validator: (v) => (v == null || v.trim().isEmpty)
                ? 'El nombre es requerido'
                : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _lastNameController,
            style: theme.textTheme.bodyLarge,
            textCapitalization: TextCapitalization.words,
            decoration: customInputDecoration(
              labelText: 'Apellido',
              icon: Icons.badge_outlined,
              context: context,
            ),
            validator: (v) => (v == null || v.trim().isEmpty)
                ? 'El apellido es requerido'
                : null,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _selectedCountry,
            items: _countries
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            onChanged: (value) => setState(() => _selectedCountry = value),
            style: theme.textTheme.bodyLarge,
            dropdownColor: theme.colorScheme.surface,
            decoration: customInputDecoration(
              labelText: 'País',
              icon: Icons.public,
              context: context,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _phoneController,
            style: theme.textTheme.bodyLarge,
            keyboardType: TextInputType.phone,
            decoration: customInputDecoration(
              labelText: 'Número de teléfono',
              icon: Icons.phone_outlined,
              context: context,
            ),
            validator: (v) => (v == null || v.trim().isEmpty)
                ? 'El teléfono es requerido'
                : null,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () =>
                      ref.read(registrationStepProvider.notifier).state--,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: theme.colorScheme.onSurface,
                    side: BorderSide(color: theme.colorScheme.outline),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Atrás'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: PrimaryButton(text: 'Siguiente', onPressed: _nextStep),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- PASO 3: FINALIZACIÓN ---

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
        TextFormField(
          controller: _referralController,
          style: theme.textTheme.bodyLarge,
          decoration: customInputDecoration(
            labelText: 'Usuario referidor (opcional)',
            icon: Icons.person_add_alt_1_outlined,
            context: context,
          ),
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
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () =>
                    ref.read(registrationStepProvider.notifier).state--,
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.colorScheme.onSurface,
                  side: BorderSide(color: theme.colorScheme.outline),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Atrás'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: PrimaryButton(
                text: 'Registrarse',
                onPressed: _submitRegistration,
                isLoading: registrationState.isLoading,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
