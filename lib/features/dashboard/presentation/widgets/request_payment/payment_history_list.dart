import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import 'package:my_app/features/dashboard/domain/entities/payment.dart';

class PaymentHistoryList extends StatelessWidget {
  final List<Payment> requests;

  const PaymentHistoryList({super.key, required this.requests});

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(AppLocalizations.of(context).requestPaymentNoPreviousRequests),
        ),
      );
    }
    return ListView.separated(
      itemCount: requests.length,
      shrinkWrap: true,
      // Para que funcione dentro de otra ListView
      physics: const NeverScrollableScrollPhysics(),
      // El scroll lo maneja el padre
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _HistoryItem(request: requests[index]);
      },
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final Payment request;

  const _HistoryItem({required this.request});

  Color _getStatusColor(RequestStatus status, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (status) {
      case RequestStatus.aprobado:
        return Colors.green.shade700;
      case RequestStatus.pendiente:
        return Colors.orange.shade700;
      case RequestStatus.rechazado:
        return colorScheme.error;
    }
  }

  String _translateStatus(RequestStatus status, BuildContext context) {
    final loc = AppLocalizations.of(context);
    switch (status) {
      case RequestStatus.aprobado:
        return loc.requestPaymentStatusApproved;
      case RequestStatus.pendiente:
        return loc.requestPaymentStatusPending;
      case RequestStatus.rechazado:
        return loc.requestPaymentStatusRejected;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    final colorScheme = Theme.of(context).colorScheme;
    final loc = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);

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
                  _translateStatus(request.status, context),
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
          _buildDetailRow(context, loc.requestPaymentObservation, request.observation),
          _buildDetailRow(context, loc.requestPaymentResponse, request.adminResponse),
          _buildDetailRow(
            context,
            loc.requestPaymentDate,
            DateFormat.yMMMd(locale.toString()).format(request.date),
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
