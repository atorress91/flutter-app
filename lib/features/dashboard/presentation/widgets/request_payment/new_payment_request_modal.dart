import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewPaymentRequestModal extends StatefulWidget {
  const NewPaymentRequestModal({super.key});

  @override
  State<NewPaymentRequestModal> createState() => _NewPaymentRequestModalState();
}

class _NewPaymentRequestModalState extends State<NewPaymentRequestModal> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _accessKeyController = TextEditingController();
  final _observationController = TextEditingController();
  final _confirmationCodeController = TextEditingController();

  bool _isCodeSending = false;
  bool _isSubmitting = false;
  bool _isPasswordVisible =
      false; // Nueva variable para controlar la visibilidad

  @override
  void dispose() {
    _amountController.dispose();
    _accessKeyController.dispose();
    _observationController.dispose();
    _confirmationCodeController.dispose();
    super.dispose();
  }

  // Simula el envío del código de seguridad
  Future<void> _sendSecurityCode() async {
    if (_isCodeSending) return;
    setState(() => _isCodeSending = true);

    // ----> LLAMADA A LA API PARA ENVIAR EL CÓDIGO <----
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enviando código de seguridad...')),
      );
    }

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Código enviado a tu dispositivo.')),
      );
      setState(() => _isCodeSending = false);
    }
  }

  // Procesa el envío del formulario completo
  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate()) {
      return; // Si la validación falla, no hacer nada.
    }
    setState(() => _isSubmitting = true);

    // ----> LLAMADA A LA API PARA ENVIAR LA SOLICITUD <----
    await Future.delayed(const Duration(seconds: 2));

    // Cierra el modal y muestra confirmación
    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Solicitud enviada con éxito.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);

    // Usar Container en lugar de Padding para mejor control del tamaño
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
            // --- Encabezado del Modal ---
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

            // --- Campos del Formulario ---
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
            // --- Campo de Clave de Acceso con Icono de Mostrar/Ocultar ---
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

            // --- Campo de Código con Botón ---
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

            // --- Botón de Envío ---
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
