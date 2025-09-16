import 'package:flutter/material.dart';
import 'package:my_app/core/l10n/app_localizations.dart';

class ClearFiltersButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ClearFiltersButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.clear),
      tooltip: l10n.purchasesClearFiltersTooltip,
    );
  }
}