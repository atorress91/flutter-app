// atorress91/flutter-app/flutter-app-37be6818c8723798eabdb53ab04d96f98bfa4bd9/lib/features/dashboard/presentation/widgets/request_payment/new_payment_request_modal.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/core/data/request/wallet_request.dart';
import 'package:my_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:my_app/features/dashboard/presentation/controllers/request_payment_screen_controller.dart';

class NewPaymentRequestModal extends ConsumerStatefulWidget {
  const NewPaymentRequestModal({super.key});

  @override
  ConsumerState<NewPaymentRequestModal> createState() =>
      _NewPaymentRequestModalState();
}

class _NewPaymentRequestModalState
    extends ConsumerState<NewPaymentRequestModal> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _accessKeyController = TextEditingController();
  final _observationController = TextEditingController();
  final _confirmationCodeController = TextEditingController();

  bool _isCodeSending = false;
  bool _isSubmitting = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _amountController.dispose();
    _accessKeyController.dispose();
    _observationController.dispose();
    _confirmationCodeController.dispose();
    super.dispose();
  }

  Future<void> _sendSecurityCode() async {
    if (_isCodeSending) return;
    setState(() => _isCodeSending = true);

    final controller = ref.read(requestPaymentControllerProvider.notifier);
    final success = await controller.generateVerificationCode();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? 'Código enviado a tu dispositivo.'
                : 'Error al enviar el código.',
          ),
        ),
      );
      setState(() => _isCodeSending = false);
    }
  }

  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _isSubmitting = true);
    final user = ref.read(authNotifierProvider).value!.user;

    final request = WalletRequest(
        affiliateId: user.id,
        affiliateName: user.userName,
        userPassword: _accessKeyController.text,
        verificationCode: _confirmationCodeController.text,
        amount: double.parse(_amountController.text),
        concept: _observationController.text);
    final controller = ref.read(requestPaymentControllerProvider.notifier);
    final success = await controller.createWalletRequest(request);

    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(success
                ? 'Solicitud enviada con éxito'
                : 'Ocurrió un error al enviar la solicitud')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
        maxWidth: MediaQuery.of(context).size.width * 0.9,
      ),
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Enviar Solicitud',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 24),

            TextFormField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Monto que Solicita *',
                prefixText: '\$ ',
              ),
              validator: (value) =>
              (value == null || value.isEmpty) ? 'Campo requerido' : null,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _accessKeyController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Clave de acceso *',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              validator: (value) =>
              (value == null || value.isEmpty) ? 'Campo requerido' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _observationController,
              decoration: const InputDecoration(labelText: 'Observación'),
            ),
            const SizedBox(height: 16),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _confirmationCodeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Código de confirmación *',
                    ),
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Campo requerido'
                        : null,
                  ),
                ),
                const SizedBox(width: 12),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: _isCodeSending
                      ? const CircularProgressIndicator()
                      : TextButton(
                    onPressed: _sendSecurityCode,
                    child: const Text('Enviar código'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isSubmitting ? null : _submitRequest,
                child: _isSubmitting
                    ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Text('Confirmar y Enviar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}