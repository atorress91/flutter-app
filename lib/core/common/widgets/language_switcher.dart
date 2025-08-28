import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'navbar_actions.dart';

class LanguageSwitcher extends StatelessWidget {
  final Language selectedLanguage;
  final ValueChanged<Language> onChanged;

  const LanguageSwitcher({
    super.key,
    required this.selectedLanguage,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Row(
        children: [
          _buildLanguageOption(
            context,
            label: 'ES',
            isSelected: selectedLanguage == Language.es,
            onTap: () => onChanged(Language.es),
          ),
          _buildLanguageOption(
            context,
            label: 'EN',
            isSelected: selectedLanguage == Language.en,
            onTap: () => onChanged(Language.en),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.onSurfaceVariant,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
