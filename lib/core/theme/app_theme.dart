import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF1A1A2E);
  static const Color accentColor = Color(0xFF00F5D4);
  static const Color darkCardColor = Color(0xFF2C2C4E);

  // Global controller for theme mode
  static final ValueNotifier<ThemeMode> themeMode = ValueNotifier<ThemeMode>(
    ThemeMode.dark,
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    cardColor: darkCardColor,

    scaffoldBackgroundColor: primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
      primary: accentColor,
      surface: primaryColor,
      outline: Colors.white.withAlpha(30),

      onSurfaceVariant: Colors.white70, // Color para íconos no seleccionados
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme,
    ).apply(bodyColor: Colors.white, displayColor: Colors.white),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    cardColor: Colors.white,

    scaffoldBackgroundColor: const Color(0xFFF0F2F5),

    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
      primary: accentColor,
      onPrimary: primaryColor,
      surface: Colors.white,
      outline: Colors.black.withAlpha(30),
      onSurfaceVariant: Colors.black54, // Color para íconos no seleccionados
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.light().textTheme,
    ).apply(bodyColor: primaryColor, displayColor: primaryColor),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: primaryColor),
    ),
  );
}
