import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileStatusBadges extends StatelessWidget {
  const ProfileStatusBadges({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      alignment: WrapAlignment.center,
      children: [
        _buildBadge(
          context,
          'KYC Autorizado',
          Icons.verified_user_outlined,
          Colors.blue.shade700,
        ),
        _buildBadge(
          context,
          'Cuenta Verificada',
          Icons.check_circle_outline,
          Colors.cyan.shade700,
        ),
        _buildBadge(
          context,
          'Activo',
          Icons.flash_on_outlined,
          Colors.green.shade700,
        ),
        _buildBadge(
          context,
          'Cliente',
          Icons.person_outline,
          Colors.purple.shade600,
        ),
      ],
    );
  }

  Widget _buildBadge(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withAlpha((255 * 0.1).toInt()),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
