import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentRequestForm extends StatefulWidget {
  const PaymentRequestForm({super.key});

  @override
  State<PaymentRequestForm> createState() => _PaymentRequestFormState();
}

class _PaymentRequestFormState extends State<PaymentRequestForm> {
  final _amountController = TextEditingController();
  final _observationController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _observationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Monto a Retirar (USD)', style: textTheme.labelLarge),
        const SizedBox(height: 8),
        TextField(
          controller: _amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            prefixText: '\$ ',
            hintText: '25.00',
          ),
        ),
        const SizedBox(height: 16),
        Text('Observación (Opcional)', style: textTheme.labelLarge),
        const SizedBox(height: 8),
        TextField(
          controller: _observationController,
          decoration: const InputDecoration(
            hintText: 'Ej: Retiro para gastos personales',
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () {
              // TODO: Implementar lógica para enviar solicitud
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Función de enviar no implementada.'),
                ),
              );
            },
            icon: const Icon(Icons.send_outlined),
            label: const Text('Enviar Solicitud'),
          ),
        ),
      ],
    );
  }
}
