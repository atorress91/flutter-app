import 'package:flutter/material.dart';
import 'app_localizations_delegate.dart';

/// AppLocalizations with modular registration support.
///
/// Besides the core translation map bundled here, modules can register
/// their own translation keys at runtime using [registerTranslations]
/// or [registerNamespace]. Registered keys take precedence over the
/// core map, enabling overrides or feature-specific additions without
/// editing this file.
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    final AppLocalizations? loc = Localizations.of<AppLocalizations>(
      context,
      AppLocalizations,
    );
    assert(loc != null, 'AppLocalizations not found in context');
    return loc!;
  }

  static const supportedLocales = [Locale('en'), Locale('es')];

  /// Additional translations registered by modules at runtime.
  /// Structure: { 'en': { 'feature.key': 'Value', ... }, 'es': {...} }
  static final Map<String, Map<String, String>> _additionalTranslations = {};

  /// Register translations by language.
  /// Example:
  /// AppLocalizations.registerTranslations({
  ///   'en': {'feature.title': 'Title'},
  ///   'es': {'feature.title': 'Título'},
  /// });
  static void registerTranslations(
    Map<String, Map<String, String>> byLanguage, {
    bool override = true,
  }) {
    byLanguage.forEach((lang, values) {
      final target = _additionalTranslations.putIfAbsent(
        lang,
        () => <String, String>{},
      );
      if (override) {
        target.addAll(values);
      } else {
        for (final entry in values.entries) {
          target.putIfAbsent(entry.key, () => entry.value);
        }
      }
    });
  }

  /// Register translations under a namespace (prefixing keys as `namespace.key`).
  static void registerNamespace(
    String namespace,
    Map<String, Map<String, String>> byLanguage, {
    bool override = true,
  }) {
    final Map<String, Map<String, String>> namespaced = {};
    byLanguage.forEach((lang, values) {
      namespaced[lang] = {
        for (final e in values.entries) '$namespace.${e.key}': e.value,
      };
    });
    registerTranslations(namespaced, override: override);
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'Modular App',
      'loginScreenTitle': 'Login Screen',
      'loginAsClient': 'Login as Client',
      'loginAsAdmin': 'Login as Admin',
      'adminDashboard': 'Admin Dashboard',
      'adminPanelTitle': 'Administration Panel',
      'configPageTitle': 'Configuration Page',
      'profilePageTitle': 'Profile Page',
      'sidebarDashboard': 'Dashboard',
      'sidebarLogoutToLogin': 'Back to Login',
      'menuTooltip': 'Collapse/Expand Menu',
      // Auth form
      'passwordLabel': 'Password',
      'signInButtonLabel': 'Sign in',
      'usernameOrEmailLabel': 'Username or email',
      'usernameOrEmailRequired': 'Enter your username or email',
      'passwordRequired': 'Enter your password',
      'passwordTooShort': 'Password is too short',
      // Home screen
      'homeWelcomeBack': 'Welcome back,',
      'homeAnnualPerformance': 'Annual Performance',
      'homeQuickActions': 'Quick Actions',
      'homeRecentActivity': 'Recent Activity',
      // Stats
      'statsTotalSales': 'Total Sales',
      'statsActiveUsers': 'Active Users',
      'statsNewOrders': 'New Orders',
      'statsRevenue': 'Revenue',
      // Quick actions
      'quickCreate': 'Create',
      'quickReports': 'Reports',
      'quickInvoices': 'Invoices',
      'quickSettings': 'Settings',
      // Recent activity items
      'activityNewSaleTitle': 'New sale made',
      'activityNewSaleSubtitle': 'Product #3452, for \$250',
      'activityUserRegisteredTitle': 'User registered',
      'activityUserRegisteredSubtitle': 'New customer: María García',
      'activityInventoryUpdatedTitle': 'Inventory updated',
      'activityInventoryUpdatedSubtitle': '25 products added',
      'activityReportGeneratedTitle': 'Report generated',
      'activityReportGeneratedSubtitle': 'Monthly report completed',
    },
    'es': {
      'appTitle': 'App Modular',
      'loginScreenTitle': 'Pantalla de Inicio de Sesión',
      'loginAsClient': 'Login como Cliente',
      'loginAsAdmin': 'Login como Admin',
      'adminDashboard': 'Panel de Administración',
      'adminPanelTitle': 'Panel de Administración',
      'configPageTitle': 'Página de Configuración',
      'profilePageTitle': 'Página de Perfil',
      'sidebarDashboard': 'Dashboard',
      'sidebarLogoutToLogin': 'Salir a Login',
      'menuTooltip': 'Contraer/Expandir Menú',
      // Auth form
      'passwordLabel': 'Contraseña',
      'signInButtonLabel': 'Iniciar sesión',
      'usernameOrEmailLabel': 'Usuario o email',
      'usernameOrEmailRequired': 'Ingresa tu usuario o email',
      'passwordRequired': 'Ingresa tu contraseña',
      'passwordTooShort': 'La contraseña es muy corta',
      // Home screen
      'homeWelcomeBack': 'Bienvenido de nuevo,',
      'homeAnnualPerformance': 'Rendimiento Anual',
      'homeQuickActions': 'Acciones Rápidas',
      'homeRecentActivity': 'Actividad Reciente',
      // Stats
      'statsTotalSales': 'Ventas Totales',
      'statsActiveUsers': 'Usuarios Activos',
      'statsNewOrders': 'Nuevos Pedidos',
      'statsRevenue': 'Ingresos',
      // Quick actions
      'quickCreate': 'Crear',
      'quickReports': 'Reportes',
      'quickInvoices': 'Facturas',
      'quickSettings': 'Ajustes',
      // Recent activity items
      'activityNewSaleTitle': 'Nueva venta realizada',
      'activityNewSaleSubtitle': 'Producto #3452, por \$250',
      'activityUserRegisteredTitle': 'Usuario registrado',
      'activityUserRegisteredSubtitle': 'Nuevo cliente: María García',
      'activityInventoryUpdatedTitle': 'Inventario actualizado',
      'activityInventoryUpdatedSubtitle': '25 productos agregados',
      'activityReportGeneratedTitle': 'Reporte generado',
      'activityReportGeneratedSubtitle': 'Reporte mensual completado',
    },
  };

  String _t(String key) {
    final lang = locale.languageCode;
    // 1) Additional (registered) translations take precedence
    final fromAdditional = _additionalTranslations[lang]?[key];
    if (fromAdditional != null) return fromAdditional;

    // 2) Core bundled translations
    final fromCore = _localizedValues[lang]?[key];
    if (fromCore != null) return fromCore;

    // 3) Fallback to English core, then to English additional
    return _localizedValues['en']?[key] ??
        _additionalTranslations['en']?[key] ??
        key;
  }

  String get appTitle => _t('appTitle');

  String get loginScreenTitle => _t('loginScreenTitle');
  
  String get passwordLabel => _t('passwordLabel');
  String get signInButtonLabel => _t('signInButtonLabel');

  String get usernameOrEmailLabel => _t('usernameOrEmailLabel');
  String get usernameOrEmailRequired => _t('usernameOrEmailRequired');
  String get passwordRequired => _t('passwordRequired');
  String get passwordTooShort => _t('passwordTooShort');

  String get loginAsClient => _t('loginAsClient');

  String get loginAsAdmin => _t('loginAsAdmin');

  String get adminDashboard => _t('adminDashboard');

  String get adminPanelTitle => _t('adminPanelTitle');

  String get configPageTitle => _t('configPageTitle');

  String get profilePageTitle => _t('profilePageTitle');

  String get sidebarDashboard => _t('sidebarDashboard');

  String get sidebarLogoutToLogin => _t('sidebarLogoutToLogin');

  String get menuTooltip => _t('menuTooltip');

  // Public helper to fetch by key (for dynamic keys)
  String t(String key) => _t(key);

  /// Public helper with namespace: tNs('dashboard', 'title') => lookup 'dashboard.title'
  String tNs(String namespace, String key) => _t('$namespace.$key');

  // Home getters
  String get homeWelcomeBack => _t('homeWelcomeBack');

  String get homeAnnualPerformance => _t('homeAnnualPerformance');

  String get homeQuickActions => _t('homeQuickActions');

  String get homeRecentActivity => _t('homeRecentActivity');

  // Stats
  String get statsTotalSales => _t('statsTotalSales');

  String get statsActiveUsers => _t('statsActiveUsers');

  String get statsNewOrders => _t('statsNewOrders');

  String get statsRevenue => _t('statsRevenue');

  // Quick actions
  String get quickCreate => _t('quickCreate');

  String get quickReports => _t('quickReports');

  String get quickInvoices => _t('quickInvoices');

  String get quickSettings => _t('quickSettings');

  // Activity
  String get activityNewSaleTitle => _t('activityNewSaleTitle');

  String get activityNewSaleSubtitle => _t('activityNewSaleSubtitle');

  String get activityUserRegisteredTitle => _t('activityUserRegisteredTitle');

  String get activityUserRegisteredSubtitle =>
      _t('activityUserRegisteredSubtitle');

  String get activityInventoryUpdatedTitle =>
      _t('activityInventoryUpdatedTitle');

  String get activityInventoryUpdatedSubtitle =>
      _t('activityInventoryUpdatedSubtitle');

  String get activityReportGeneratedTitle => _t('activityReportGeneratedTitle');

  String get activityReportGeneratedSubtitle =>
      _t('activityReportGeneratedSubtitle');
}
