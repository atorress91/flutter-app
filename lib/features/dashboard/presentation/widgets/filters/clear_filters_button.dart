import 'package:flutter/material.dart';

class ClearFiltersButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ClearFiltersButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.clear),
      tooltip: 'Limpiar filtros',
    );
  }
}