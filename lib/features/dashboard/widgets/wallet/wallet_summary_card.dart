import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletSummaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const WalletSummaryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // Distribuye el espacio uniformemente
        children: [
          CircleAvatar(
            backgroundColor: color.withAlpha((255 * 0.1).toInt()),
            radius: 20,
            child: Icon(icon, color: color, size: 20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis, // Previene overflow del texto
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: textTheme.bodySmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withAlpha((255 * 0.6).toInt()),
                ),
                overflow: TextOverflow.ellipsis, // Previene overflow del texto
              ),
            ],
          ),
        ],
      ),
    );
  }
}
