import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import 'package:my_app/features/dashboard/domain/entities/payment.dart';
import 'package:my_app/features/dashboard/presentation/widgets/request_payment/payment_status_chip.dart';

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
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return _HistoryItem(request: requests[index]);
      },
    );
  }
}

// NUEVA VERSION VIRTUALIZADA PARA USO EN SLIVERS
class PaymentHistorySliverList extends StatelessWidget {
  final List<Payment> requests;
  const PaymentHistorySliverList({super.key, required this.requests});

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16),
            child: Text(AppLocalizations.of(context).requestPaymentNoPreviousRequests),
          ),
        ),
      );
    }
    final total = requests.length * 2 - 1; // items + separadores
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index.isOdd) {
            return const SizedBox(height: 16);
          }
          final itemIndex = index >> 1; // index / 2
          final payment = requests[itemIndex];
          return _HistoryItem(
            key: ValueKey('payment-$itemIndex-${payment.date.millisecondsSinceEpoch}-${payment.amount}-${payment.status.name}'),
            request: payment,
          );
        },
        childCount: total,
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final Payment request;

  const _HistoryItem({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    final colorScheme = Theme.of(context).colorScheme;
    final loc = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);

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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    request.type == 'withdrawal_request'
                        ? AppLocalizations.of(context).requestPaymentTypeWithdrawalRequest
                        : request.type,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  flex: 0,
                  child: Text(
                    DateFormat('dd/MM/yyyy', locale.toString()).format(request.date),
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              ],
            ),
            const Divider(height: 32, thickness: 0.5),
            // Details
            _buildDetailRow(context, loc.requestPaymentObservation, request.observation),
            _buildDetailRow(
              context,
              loc.requestPaymentDate,
              DateFormat.yMMMd(locale.toString()).format(request.date),
            ),
            const SizedBox(height: 12),
            // Footer: status + amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PaymentStatusChip(status: request.status),
                Text(
                  '\$ ${request.amount.toStringAsFixed(2)}',
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
    );
  }

  Widget _buildDetailRow(BuildContext context, String title, String value) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface.withAlpha((255 * 0.6).toInt()),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value.isEmpty ? '-' : value,
              style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
