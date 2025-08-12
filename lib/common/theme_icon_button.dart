import 'package:flutter/material.dart';

class ThemeIconButton extends StatelessWidget {
  final String tooltip;
  final bool isSelected;
  final IconData icon;
  final VoidCallback onTap;

  const ThemeIconButton({
    super.key,
    required this.tooltip,
    required this.isSelected,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF00F5D4) : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 22,
            color: isSelected
                ? const Color(0xFF1A1A2E)
                : (isDark ? Colors.white70 : Colors.black54),
          ),
        ),
      ),
    );
  }
}