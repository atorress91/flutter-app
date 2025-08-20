import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/features/dashboard/domain/entities/purchase_status.dart';

class StatusChip extends StatelessWidget {
  final PurchaseStatus status;

  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final config = _getStatusConfig(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: config.color.withAlpha((255 * 0.1).toInt()),
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

  _StatusConfig _getStatusConfig(PurchaseStatus status) {
    switch (status) {
      case PurchaseStatus.completado:
        return _StatusConfig(
          label: 'Completado',
          color: Colors.green.shade700,
          icon: Icons.check_circle_outline,
        );
      case PurchaseStatus.procesando:
        return _StatusConfig(
          label: 'Procesando',
          color: Colors.orange.shade700,
          icon: Icons.hourglass_top_outlined,
        );
      case PurchaseStatus.devuelto:
        return _StatusConfig(
          label: 'Devuelto',
          color: Colors.red.shade700,
          icon: Icons.cancel_outlined,
        );
    }
  }
}

class _StatusConfig {
  final String label;
  final Color color;
  final IconData icon;

  _StatusConfig({required this.label, required this.color, required this.icon});
}
