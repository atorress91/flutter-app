import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF1A1A2E);
  static const Color darkCardColor = Color(0xFF2C2C4E);
  static const Color accentGreenColor = Color(0xFF00BD86);
  static const Color accentYellowColor = Color(0xFFC5FC44);

  // Logo paths for different themes
  static const String darkBannerLogo = 'assets/images/recycoin-banner.png';
  static const String lightBannerLogo = 'assets/images/recycoin-banner-green.png';

  // Global controller for theme mode
  static final ValueNotifier<ThemeMode> themeMode = ValueNotifier<ThemeMode>(
    ThemeMode.dark,
  );

  // Method to get the appropriate logo based on current theme
  static String getLogoPath(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? darkBannerLogo : lightBannerLogo;
  }

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    cardColor: darkCardColor,

    scaffoldBackgroundColor: primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
      primary: accentYellowColor,
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
      primary: accentGreenColor,
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
