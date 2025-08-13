import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/transaction.dart';
import 'transaction_status_chip.dart';
import 'meta_pill.dart';
import 'money_amount.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback? onTap;

  const TransactionCard({super.key, required this.transaction, this.onTap});

  bool get _isCredit => transaction.credit > 0.0;

  IconData get _leadingIcon =>
      _isCredit ? Icons.trending_up_rounded : Icons.trending_down_rounded;

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    final colorScheme = Theme.of(context).colorScheme;
    final formatCurrency = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$ ',
    );
    final formatDate = DateFormat.yMMMd('es_CR').add_jm();

    final leadingBg = _isCredit
        ? Colors.green.withAlpha((255 * 0.12).toInt())
        : Colors.red.withAlpha((255 * 0.12).toInt());
    final amountColor = _isCredit ? Colors.green.shade700 : Colors.red.shade700;
    final amountValue = _isCredit ? transaction.credit : transaction.debit;

    final showCredit = transaction.credit > 0;
    final showDebit = transaction.debit > 0;

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
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withAlpha((255 * 0.04).toInt()),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icono principal
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: leadingBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(_leadingIcon, color: amountColor, size: 22),
                ),
                const SizedBox(width: 12),

                // Contenido
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título + estado
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              transaction.concept,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          TransactionStatusChip(status: transaction.status),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        formatDate.format(transaction.date),
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Meta: usuario - afiliado
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          MetaPill(
                            icon: Icons.person_outline_rounded,
                            label: transaction.responsibleUser,
                          ),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: colorScheme.outlineVariant,
                              shape: BoxShape.circle,
                            ),
                          ),
                          MetaPill(
                            icon: Icons.business_outlined,
                            label: transaction.affiliate,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      Divider(
                        height: 16,
                        thickness: 1,
                        color: colorScheme.outlineVariant.withAlpha(
                          (255 * 0.4).toInt(),
                        ),
                      ),

                      // Montos: solo mostrar el que aplique (> 0)
                      if (showCredit || showDebit)
                        Row(
                          children: [
                            if (showCredit)
                              Expanded(
                                child: MoneyAmount(
                                  title: 'Crédito',
                                  value: transaction.credit,
                                  color: Colors.green.shade700,
                                  alignRight: showDebit ? false : false,
                                ),
                              ),
                            if (showDebit)
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
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Monto principal + chevron
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatCurrency.format(amountValue),
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: amountColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 20,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
