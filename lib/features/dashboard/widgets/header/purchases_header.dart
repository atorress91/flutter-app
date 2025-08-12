import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'export_button.dart';

class PurchasesHeader extends StatelessWidget {
  final VoidCallback onExportPdf;

  const PurchasesHeader({
    super.key,
    required this.onExportPdf,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            'Mis compras',
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        ExportButton(onPressed: onExportPdf),
      ],
    );
  }
}