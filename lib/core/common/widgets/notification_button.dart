import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NotificationButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: theme.cardColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: theme.colorScheme.outline,
            ),
          ),
          child: Icon(
            Icons.notifications_none_rounded,
            color: theme.colorScheme.onSurfaceVariant,
            size: 22,
          ),
        ),
      ),
    );
  }
}