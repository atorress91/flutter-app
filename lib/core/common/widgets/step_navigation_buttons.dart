import 'package:flutter/material.dart';
import 'package:my_app/core/common/widgets/primary_button.dart';

class StepNavigationButtons extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onNext;
  final String nextText;
  final bool isLoading;
  final bool showBack;

  const StepNavigationButtons({
    super.key,
    this.onBack,
    this.onNext,
    this.nextText = 'Siguiente',
    this.isLoading = false,
    this.showBack = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (!showBack) {
      return PrimaryButton(
        text: nextText,
        onPressed: onNext,
        isLoading: isLoading,
      );
    }

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onBack,
            style: OutlinedButton.styleFrom(
              foregroundColor: theme.colorScheme.onSurface,
              side: BorderSide(color: theme.colorScheme.outline),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text('Atrás'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: PrimaryButton(
            text: nextText,
            onPressed: onNext,
            isLoading: isLoading,
          ),
        ),
      ],
    );
  }
}
