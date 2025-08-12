import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NotificationButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C4E),
            shape: BoxShape.circle,
            border: Border.all(
              color: isDark
                  ? Colors.white.withAlpha((255 * 0.1).toInt())
                  : Colors.black.withAlpha((255 * 0.1).toInt()),
            ),
          ),
          child: Icon(
            Icons.notifications_none_rounded,
            color: isDark ? Colors.white70 : Colors.black54,
            size: 22,
          ),
        ),
      ),
    );
  }
}