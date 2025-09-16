import 'package:flutter/material.dart';
import 'package:my_app/core/l10n/app_localizations.dart';

class ExportButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ExportButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Tooltip(
      message: l10n.purchasesExportPdfTooltip,
      child: TextButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.picture_as_pdf_outlined),
        label: Text(l10n.purchasesExportButton),
      ),
    );
  }
}