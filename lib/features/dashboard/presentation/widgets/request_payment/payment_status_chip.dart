import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import 'package:my_app/features/dashboard/domain/entities/payment.dart';

class PaymentStatusChip extends StatelessWidget {
  final RequestStatus status;

  const PaymentStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final config = _getConfig(context, status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: config.color.withAlpha((255 * 0.10).toInt()),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(config.icon, color: config.color, size: 14),
          const SizedBox(width: 6),
          Text(
            config.label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: config.color,
            ),
          ),
        ],
      ),
    );
  }

  _PaymentStatusConfig _getConfig(BuildContext context, RequestStatus status) {
    final l10n = AppLocalizations.of(context);
    switch (status) {
      case RequestStatus.aprobado:
        return _PaymentStatusConfig(
          label: l10n.requestPaymentStatusApproved,
          color: Colors.green.shade700,
          icon: Icons.check_circle_outline,
        );
      case RequestStatus.pendiente:
        return _PaymentStatusConfig(
          label: l10n.requestPaymentStatusPending,
          color: Colors.orange.shade700,
          icon: Icons.schedule_outlined,
        );
      case RequestStatus.rechazado:
        return _PaymentStatusConfig(
          label: l10n.requestPaymentStatusRejected,
          color: Theme.of(context).colorScheme.error,
          icon: Icons.cancel_outlined,
        );
    }
  }
}

class _PaymentStatusConfig {
  final String label;
  final Color color;
  final IconData icon;

  _PaymentStatusConfig({required this.label, required this.color, required this.icon});
}

