import 'package:flutter/material.dart';

class ExportButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ExportButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Exportar PDF',
      child: TextButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.picture_as_pdf_outlined),
        label: const Text('Exportar'),
      ),
    );
  }
}