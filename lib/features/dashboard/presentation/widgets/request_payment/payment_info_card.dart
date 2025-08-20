import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentInfoCard extends StatelessWidget {
  final double availableBalance;
  final double minimumAmount;

  const PaymentInfoCard({
    super.key,
    required this.availableBalance,
    required this.minimumAmount,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'El monto mínimo para procesar el pago es de USD \$${minimumAmount.toStringAsFixed(2)}',
                  style: textTheme.bodySmall,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Text(
            'Saldo Disponible en Billetera:',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withAlpha((255 * 0.7).toInt()),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '\$ ${availableBalance.toStringAsFixed(2)}',
            style: textTheme.headlineSmall?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
