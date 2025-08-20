import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContractDetails extends StatelessWidget {
  const ContractDetails({super.key});

  // Widget auxiliar para crear cada fila de detalle
  Widget _buildDetailRow(
    BuildContext context, {
    required String title,
    required String value,
    IconData? trailingIcon,
  }) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textTheme.bodyMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withAlpha((255 * 0.7).toInt()),
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (trailingIcon != null) ...[
                const SizedBox(width: 8),
                Icon(
                  trailingIcon,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow(
            context,
            title: 'Contrato',
            // Acortamos la dirección para que quepa mejor
            value: '0x7c48...6723',
            trailingIcon: Icons.copy_all_outlined, // Icono para copiar
          ),
          const Divider(),
          _buildDetailRow(context, title: 'Venta pública', value: '01-08-2026'),
          const Divider(),
          _buildDetailRow(context, title: 'Red', value: 'BNB Smart Chain'),
        ],
      ),
    );
  }
}
