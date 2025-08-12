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
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C4E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withAlpha((255 * 0.1).toInt())
              : Colors.black.withAlpha((255 * 0.1).toInt()),
        ),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00F5D4) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? const Color(0xFF1A1A2E)
                  : (isDark ? Colors.white70 : Colors.black54),
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}