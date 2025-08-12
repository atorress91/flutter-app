import 'package:flutter/material.dart';

class AppLocale {
  static final ValueNotifier<Locale> locale = ValueNotifier(const Locale('es'));

  static void setEnglish() => locale.value = const Locale('en');
  static void setSpanish() => locale.value = const Locale('es');

  static void set(Locale l) => locale.value = l;

  /// Set locale by languageCode, e.g. 'en', 'es'. Falls back to 'en' if unknown.
  static void setByCode(String languageCode) {
    switch (languageCode) {
      case 'es':
        setSpanish();
        break;
      case 'en':
        setEnglish();
        break;
      default:
        locale.value = Locale(languageCode);
        break;
    }
  }

  /// Simple toggle between 'en' and 'es' for quick testing.
  static void toggle() {
    locale.value = locale.value.languageCode == 'en' ? const Locale('es') : const Locale('en');
  }
}