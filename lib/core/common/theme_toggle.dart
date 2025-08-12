import 'package:flutter/material.dart';
import 'package:my_app/core/theme/app_theme.dart';
import 'package:my_app/core/common/theme_icon_button.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppTheme.themeMode,
      builder: (context, mode, _) {
        final isDark = mode == ThemeMode.dark;
        final borderColor = Theme.of(context).brightness == Brightness.dark
            ? Colors.white.withAlpha((255 * 0.1).toInt())
            : Colors.black.withAlpha((255 * 0.1).toInt());

        return Container(
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C4E),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ThemeIconButton(
                tooltip: 'Tema claro',
                isSelected: !isDark,
                icon: Icons.wb_sunny_outlined,
                onTap: () => AppTheme.themeMode.value = ThemeMode.light,
              ),
              ThemeIconButton(
                tooltip: 'Tema oscuro',
                isSelected: isDark,
                icon: Icons.dark_mode_outlined,
                onTap: () => AppTheme.themeMode.value = ThemeMode.dark,
              ),
            ],
          ),
        );
      },
    );
  }
}