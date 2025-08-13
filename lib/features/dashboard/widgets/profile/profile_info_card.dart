import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        children: [
          _buildInfoRow(
            context,
            Icons.phone_outlined,
            'Teléfono',
            '6083320715',
          ),
          const Divider(),
          _buildInfoRow(
            context,
            Icons.location_on_outlined,
            'Dirección',
            '3144 keswick dr',
          ),
          const Divider(),
          _buildInfoRow(
            context,
            Icons.email_outlined,
            'Correo',
            'loryplaza@gmail.com',
          ),
          const Divider(),
          _buildInfoRow(
            context,
            Icons.calendar_today_outlined,
            'Fecha Registro',
            DateFormat.yMMMd(
              'es_CR',
            ).add_jm().format(DateTime.parse('2024-08-15 01:30:25')),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 16),
          Text(title, style: textTheme.bodyMedium),
          const Spacer(),
          Expanded(
            flex: 2,
            child: Text(
              value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
