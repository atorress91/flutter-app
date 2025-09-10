import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_app/features/dashboard/domain/entities/transaction.dart';
import 'meta_pill.dart';
import 'money_amount.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback? onTap;

  const TransactionCard({super.key, required this.transaction, this.onTap});

  bool get _isCredit => transaction.credit > 0.0;

  IconData get _statusIcon {
    switch (transaction.status) {
      case TransactionStatus.atendido:
        return Icons.check_circle_outline;
      case TransactionStatus.pendiente:
        return Icons.hourglass_top_outlined;
    }
  }

  Color _getStatusColor(BuildContext context) {
    switch (transaction.status) {
      case TransactionStatus.atendido:
        return Colors.green.shade600;
      case TransactionStatus.pendiente:
        return Colors.orange.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    final colorScheme = Theme.of(context).colorScheme;
    final formatDate = DateFormat.yMMMd('es_CR').add_jm();
    final amountColor = _isCredit ? Colors.green.shade700 : Colors.red.shade700;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorScheme.outline.withAlpha((255 * 0.18).toInt()),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            _isCredit
                                ? Icons.trending_up_rounded
                                : Icons.trending_down_rounded,
                            color: amountColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              transaction.concept,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            _statusIcon,
                            color: _getStatusColor(context),
                            size: 20,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: Text(
                          formatDate.format(transaction.date),
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            MetaPill(
                              icon: Icons.person_outline_rounded,
                              label: transaction.responsibleUser,
                            ),
                            MetaPill(
                              icon: Icons.business_outlined,
                              label: transaction.affiliate,
                            ),
                          ],
                        ),
                      ),
                      if (transaction.credit > 0 || transaction.debit > 0) ...[
                        const SizedBox(height: 10),
                        const Divider(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0),
                          child: Row(
                            children: [
                              if (transaction.credit > 0)
                                Expanded(
                                  child: MoneyAmount(
                                    title: 'Crédito',
                                    value: transaction.credit,
                                    color: Colors.green.shade700,
                                  ),
                                ),
                              if (transaction.debit > 0)
                                Expanded(
                                  child: MoneyAmount(
                                    title: 'Débito',
                                    value: transaction.debit,
                                    color: Colors.red.shade700,
                                    alignRight: true,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
