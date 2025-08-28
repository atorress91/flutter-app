import 'package:flutter/material.dart';
import 'package:my_app/core/theme/app_theme.dart';
import 'package:my_app/core/common/widgets/theme_icon_button.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppTheme.themeMode,
      builder: (context, mode, _) {
        final theme = Theme.of(context);
        final isDark = mode == ThemeMode.dark;

        return Container(
          height: 40,
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: theme.colorScheme.outline),
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
