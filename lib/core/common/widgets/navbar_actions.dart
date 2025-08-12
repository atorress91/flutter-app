import 'package:flutter/material.dart';
import 'package:my_app/core/common/widgets/theme_toggle.dart';
import 'package:my_app/core/l10n/app_locale.dart';

import 'language_switcher.dart';
import 'notification_button.dart';

enum Language { en, es }

class NavbarActions extends StatefulWidget {
  const NavbarActions({super.key});

  @override
  State<NavbarActions> createState() => _NavbarActionsState();
}

class _NavbarActionsState extends State<NavbarActions> {
  Language _selectedLanguage = Language.es;

  @override
  void initState() {
    super.initState();
    // Initialize from current app locale
    final current = AppLocale.locale.value.languageCode;
    _selectedLanguage = current == 'en' ? Language.en : Language.es;
  }

  void _onLanguageChange(Language language) {
    setState(() {
      _selectedLanguage = language;
      if (language == Language.en) {
        AppLocale.setEnglish();
      } else {
        AppLocale.setSpanish();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ThemeToggle(),
        const SizedBox(width: 12),
        LanguageSwitcher(
          selectedLanguage: _selectedLanguage,
          onChanged: _onLanguageChange,
        ),
        NotificationButton(onPressed: () {}),
        const SizedBox(width: 16),
      ],
    );
  }
}