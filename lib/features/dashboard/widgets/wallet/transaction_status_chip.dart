import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/transaction.dart';

class TransactionStatusChip extends StatelessWidget {
  final TransactionStatus status;

  const TransactionStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final textTheme = GoogleFonts.poppinsTextTheme(theme.textTheme);

    final config = _configFor(status, scheme);

    final bg = config.color.withAlpha((255 * 0.12).toInt());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: config.color.withAlpha((255 * 0.32).toInt())),
      ),
      child: Text(
        config.label,
        style: (textTheme.labelSmall ?? theme.textTheme.labelSmall)?.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
          color: config.color,
        ),
      ),
    );
  }

  _StatusVisual _configFor(TransactionStatus status, ColorScheme scheme) {
    switch (status) {
      case TransactionStatus.Atendido:
        return _StatusVisual('Atendido', scheme.primary);
      case TransactionStatus.Pendiente:
        return _StatusVisual('Pendiente', scheme.tertiary);
      case TransactionStatus.Fallido:
        return _StatusVisual('Fallido', scheme.error);
    }
  }
}

class _StatusVisual {
  final String label;
  final Color color;

  _StatusVisual(this.label, this.color);
}
