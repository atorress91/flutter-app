import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/features/dashboard/domain/entities/support_ticket.dart';

class TicketStatusChip extends StatelessWidget {
  final TicketStatus status;

  const TicketStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final config = _getStatusConfig(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: config.color.withAlpha((255 * 0.1).toInt()),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        config.label,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: config.color,
        ),
      ),
    );
  }

  _StatusConfig _getStatusConfig(TicketStatus status) {
    switch (status) {
      case TicketStatus.abierto:
        return _StatusConfig(label: 'Abierto', color: Colors.blue.shade600);
      case TicketStatus.enProceso:
        return _StatusConfig(label: 'En Proceso', color: Colors.orange.shade700);
      case TicketStatus.cerrado:
        return _StatusConfig(label: 'Cerrado', color: Colors.green.shade700);
    }
  }
}

class _StatusConfig {
  final String label;
  final Color color;

  _StatusConfig({required this.label, required this.color});
}