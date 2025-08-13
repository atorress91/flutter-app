import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/transaction.dart';

class TransactionHistoryList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionHistoryList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const Center(child: Text('No hay movimientos recientes.'));
    }
    return ListView.separated(
      itemCount: transactions.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _TransactionItemCard(transaction: transactions[index]);
      },
    );
  }
}

class _TransactionItemCard extends StatelessWidget {
  final Transaction transaction;

  const _TransactionItemCard({required this.transaction});

  // Helper para el color del estado
  Color _getStatusColor(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.Atendido:
        return Colors.green;
      case TransactionStatus.Pendiente:
        return Colors.orange;
      case TransactionStatus.Fallido:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    final colorScheme = Theme.of(context).colorScheme;
    final _ = NumberFormat.currency(locale: 'en_US', symbol: '\$');
    final formatDate = DateFormat.yMMMd('es_CR').add_jms();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor.withAlpha((255 * 0.5).toInt()),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fila superior: Concepto y Estado
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  transaction.concept,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(
                    transaction.status,
                  ).withAlpha((255 * 0.1).toInt()),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  transaction.status.name,
                  style: textTheme.labelSmall?.copyWith(
                    color: _getStatusColor(transaction.status),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            formatDate.format(transaction.date),
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface.withAlpha((255 * 0.6).toInt()),
            ),
          ),
          const Divider(height: 20),

          // Fila de detalles de usuario
          _buildDetailRow(context, 'Usuario:', transaction.responsibleUser),
          _buildDetailRow(context, 'Afiliado:', transaction.affiliate),
          const Divider(height: 20),

          // Fila de Crédito y Débito
          Row(
            children: [
              Expanded(
                child: _buildMoneyColumn(
                  context,
                  'Crédito',
                  transaction.credit,
                  Colors.green.shade700,
                ),
              ),
              Expanded(
                child: _buildMoneyColumn(
                  context,
                  'Débito',
                  transaction.debit,
                  Colors.red.shade700,
                ),
              ),
            ],
          ),

          // Fila de acciones
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                /* TODO: Implementar acción */
              },
              child: const Text('Ver Detalles'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String title, String value) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withAlpha((255 * 0.7).toInt()),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoneyColumn(
    BuildContext context,
    String title,
    double value,
    Color color,
  ) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.bodySmall?.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withAlpha((255 * 0.6).toInt()),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          NumberFormat.currency(locale: 'en_US', symbol: '\$ ').format(value),
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
