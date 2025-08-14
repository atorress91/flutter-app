import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_app/core/app_router.dart';
import 'package:my_app/core/config/environments.dart';
import 'package:my_app/core/theme/app_theme.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import 'package:my_app/core/l10n/app_locale.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  if(kReleaseMode){
    Environment.configureProduction();
  } else {
    // Estamos en desarrollo
    Environment.configureLocal();
  }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppTheme.themeMode,
      builder: (context, mode, _) {
        return ValueListenableBuilder<Locale>(
          valueListenable: AppLocale.locale,
          builder: (context, locale, _) {
            return MaterialApp.router(
              title: AppLocalizations(locale).appTitle,
              debugShowCheckedModeBanner: false,
              routerConfig: appRouter,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: mode,
              locale: locale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
            );
          },
        );
      },
    );
  }
}