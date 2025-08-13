import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/payment_request.dart';

class PaymentHistoryList extends StatelessWidget {
  final List<PaymentRequest> requests;

  const PaymentHistoryList({super.key, required this.requests});

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text('No tienes solicitudes anteriores.'),
        ),
      );
    }
    return ListView.separated(
      itemCount: requests.length,
      shrinkWrap: true,
      // Para que funcione dentro de otra ListView
      physics: const NeverScrollableScrollPhysics(),
      // El scroll lo maneja el padre
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _HistoryItem(request: requests[index]);
      },
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final PaymentRequest request;

  const _HistoryItem({required this.request});

  Color _getStatusColor(RequestStatus status, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (status) {
      case RequestStatus.Aprobado:
        return Colors.green.shade700;
      case RequestStatus.Pendiente:
        return Colors.orange.shade700;
      case RequestStatus.Rechazado:
        return colorScheme.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    final colorScheme = Theme.of(context).colorScheme;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$ ${request.amount.toStringAsFixed(2)}',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(
                    request.status,
                    context,
                  ).withAlpha((255 * 0.1).toInt()),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  request.status.name,
                  style: textTheme.labelSmall?.copyWith(
                    color: _getStatusColor(request.status, context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Text(
            request.type,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface.withAlpha((255 * 0.6).toInt()),
            ),
          ),
          const Divider(height: 20),
          _buildDetailRow(context, 'Observación:', request.observation),
          _buildDetailRow(context, 'Respuesta:', request.adminResponse),
          _buildDetailRow(
            context,
            'Fecha:',
            DateFormat.yMMMd('es_CR').format(request.date),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String title, String value) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
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
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
