import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/core/utils/currency_utils.dart';
import 'package:my_app/core/utils/date_formatter.dart';
import 'package:my_app/features/dashboard/domain/entities/invoice_detail.dart';
import 'package:my_app/features/dashboard/domain/entities/purchase.dart';

import 'status_chip.dart';

class PurchaseCard extends StatelessWidget {
  final Purchase purchase;

  const PurchaseCard({super.key, required this.purchase});

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outline.withAlpha((255 * 0.2).toInt()),
        ),
      ),
      color: colorScheme.surface,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _onCardTapped(context),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '#${purchase.invoiceNo}',
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  Text(
                    DateFormatter.long(purchase.createdAt),
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),

              // --- SECCIÓN DE DETALLES REFACTORIZADA ---
              _buildDetailsSection(context, purchase.details),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StatusChip(status: purchase.status),
                  Text(
                    CurrencyUtils.format(purchase.amount, symbol: 'USD '),
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// NUEVO WIDGET para construir la sección de detalles
  Widget _buildDetailsSection(
    BuildContext context,
    List<InvoiceDetail> details,
  ) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    final colorScheme = Theme.of(context).colorScheme;

    if (details.isEmpty) {
      return Text(
        'Sin detalles disponibles',
        style: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      );
    }

    // Usamos Wrap para que los chips se ajusten si no caben en una línea
    return Wrap(
      spacing: 8.0, // Espacio horizontal entre chips
      runSpacing: 4.0, // Espacio vertical si hay varias líneas
      children: details.map((detail) {
        return Chip(
          avatar: CircleAvatar(
            backgroundColor: colorScheme.primary,
            child: Text(
              '${detail.productQuantity}',
              style: TextStyle(color: colorScheme.onPrimary, fontSize: 12),
            ),
          ),
          label: Text(detail.productName),
          backgroundColor: colorScheme.primary.withAlpha((255*0.1).toInt()),
          side: BorderSide.none,
        );
      }).toList(),
    );
  }

  void _onCardTapped(BuildContext context) {
    // TODO: Implementar navegación a la vista de detalle de la compra
  }
}
