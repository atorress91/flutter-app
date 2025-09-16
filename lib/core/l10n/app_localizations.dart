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
      'loginScreenTitle': 'Login',
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
      // Biometric prompt
      'enableBiometricsTitle': 'Enable Biometric Login?',
      'enableBiometricsContent':
          'Would you like to use your fingerprint for faster logins next time?',
      'cancelButtonLabel': 'Cancel',
      'enableButtonLabel': 'Enable',
      // Home screen
      'homeWelcomeBack': 'Welcome back,',
      'homeAnnualPerformance': 'Network Purchases',
      'homeQuickActions': 'Quick Actions',
      'homeRecentActivity': 'Recent Activity',
      // Stats
      'statsRecycoinTotal': 'Total Recycoin',
      'statsBonusTokens': 'Bonus Tokens',
      'statsMonthlyCommission': 'Commission',
      'statsReferrals': 'Referrals',
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
      // Profile screen
      'profileTitle': 'My Profile',
      'profileErrorOccurred': 'An error occurred',
      'profileNoUserDataFound': 'No user data found.',
      'profilePhotoUpdated': 'Profile photo updated!',
      'profileMainDataTitle': 'Main Data',
      'profileSecondaryDataTitle': 'Secondary Data',
      'profileAdditionalDataTitle': 'Additional Data',
      'profileUserLabel': 'User',
      'profileEmailLabel': 'Email',
      'profileIdentificationLabel': 'Identification',
      'profileRegistrationDateLabel': 'Registration Date',
      'profileBirthDateLabel': 'Birth Date',
      'profileNameLabel': 'Name',
      'profileLastNameLabel': 'Last Name',
      'profileAddressLabel': 'Address',
      'profilePhoneLabel': 'Phone',
      'profileBeneficiaryNameLabel': 'Beneficiary Name',
      'profileBeneficiaryEmailLabel': 'Beneficiary Email',
      'profileBeneficiaryPhoneLabel': 'Beneficiary Phone',
      'profileNotSpecified': 'Not specified',
      'profileEditButton': 'Edit Profile',
      'profileLogoutButton': 'Log Out',
      // Edit profile screen
      'editProfileTitle': 'Edit Profile',
      'editProfileSaveButton': 'Save',
      'editProfileSaveChangesButton': 'Save Changes',
      'editProfileUpdatedSuccess': 'Profile updated successfully',
      // Edit profile sections
      'editProfilePersonalInfoTitle': 'Personal Information',
      'editProfileContactInfoTitle': 'Contact Information',
      'editProfileBeneficiaryInfoTitle': 'Beneficiary Information',
      'editProfileNameLabel': 'Name',
      'editProfileLastNameLabel': 'Last Name',
      'editProfilePhoneLabel': 'Phone',
      'editProfileAddressLabel': 'Address',
      'editProfileBeneficiaryNameLabel': 'Beneficiary Name',
      'editProfileBeneficiaryEmailLabel': 'Beneficiary Email',
      'editProfileBeneficiaryPhoneLabel': 'Beneficiary Phone',
      // Purchases screen
      'purchasesTitle': 'My Purchases',
      'purchasesExportPdfFunction': 'PDF export function not implemented.',
      'purchasesExportPdfTooltip': 'Export PDF',
      'purchasesExportButton': 'Export',
      'purchasesTotalPurchases': 'Total Purchases',
      'purchasesExpenseLast30Days': 'Expense (last 30 days)',
      'purchasesFiltersTitle': 'Filters',
      'purchasesSearchPlaceholder': 'Search by Invoice No., Model...',
      'purchasesDateRangeHelp': 'Select a date range',
      'purchasesDateRangeSave': 'Apply',
      'purchasesAnyDate': 'Any date',
      'purchasesClearFiltersTooltip': 'Clear filters',
      'purchasesNoResultsTitle': 'No purchases found',
      'purchasesNoResultsSubtitle': 'Try adjusting the filters or using another search term.',
      'purchasesNoDetailsAvailable': 'No details available',
      'purchasesStatusCompleted': 'Completed',
      'purchasesStatusReturned': 'Returned',
      // Wallet screen
      'walletTitle': 'My Wallet',
      'walletAvailable': 'Available',
      'walletEarned': 'Earned',
      'walletTokens': 'Tokens',
      'walletRecentMovements': 'Recent Movements',
      'walletFilterAll': 'All',
      'walletFilterIncome': 'Income',
      'walletFilterExpenses': 'Expenses',
      'walletCredit': 'Credit',
      'walletDebit': 'Debit',
    },
    'es': {
      'appTitle': 'App Modular',
      'loginScreenTitle': 'Inicio de Sesión',
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
      // Biometric prompt
      'enableBiometricsTitle': '¿Activar inicio biométrico?',
      'enableBiometricsContent':
          '¿Te gustaría usar tu huella para iniciar sesión más rápido la próxima vez?',
      'cancelButtonLabel': 'Cancelar',
      'enableButtonLabel': 'Activar',
      // Home screen
      'homeWelcomeBack': 'Bienvenido de nuevo,',
      'homeAnnualPerformance': 'Compras en red',
      'homeQuickActions': 'Acciones Rápidas',
      'homeRecentActivity': 'Actividad Reciente',
      // Stats
      'statsRecycoinTotal': 'Recycoin totales',
      'statsBonusTokens': 'Bonos tokens',
      'statsMonthlyCommission': 'Comisión mensual',
      'statsReferrals': 'Referidos',
      // Quick actions
      'quickCreate': 'Retirar',
      'quickReports': 'Reportes',
      'quickInvoices': 'Facturas',
      'quickSettings': 'Movimientos',
      // Recent activity items
      'activityNewSaleTitle': 'Nueva venta realizada',
      'activityNewSaleSubtitle': 'Producto #3452, por \$250',
      'activityUserRegisteredTitle': 'Usuario registrado',
      'activityUserRegisteredSubtitle': 'Nuevo cliente: María García',
      'activityInventoryUpdatedTitle': 'Inventario actualizado',
      'activityInventoryUpdatedSubtitle': '25 productos agregados',
      'activityReportGeneratedTitle': 'Reporte generado',
      'activityReportGeneratedSubtitle': 'Reporte mensual completado',
      // Profile screen
      'profileTitle': 'Mi Perfil',
      'profileErrorOccurred': 'Ocurrió un error',
      'profileNoUserDataFound': 'No se encontraron datos del usuario.',
      'profilePhotoUpdated': '¡Foto de perfil actualizada!',
      'profileMainDataTitle': 'Datos Principales',
      'profileSecondaryDataTitle': 'Datos Secundarios',
      'profileAdditionalDataTitle': 'Adicionales',
      'profileUserLabel': 'Usuario',
      'profileEmailLabel': 'Correo',
      'profileIdentificationLabel': 'Identificación',
      'profileRegistrationDateLabel': 'Fecha de Registro',
      'profileBirthDateLabel': 'Fecha de Nacimiento',
      'profileNameLabel': 'Nombre',
      'profileLastNameLabel': 'Apellido',
      'profileAddressLabel': 'Dirección',
      'profilePhoneLabel': 'Teléfono',
      'profileBeneficiaryNameLabel': 'Nombre Beneficiario',
      'profileBeneficiaryEmailLabel': 'Correo del Beneficiario',
      'profileBeneficiaryPhoneLabel': 'Teléfono del Beneficiario',
      'profileNotSpecified': 'No especificada',
      'profileEditButton': 'Editar Perfil',
      'profileLogoutButton': 'Cerrar Sesión',
      // Edit profile screen
      'editProfileTitle': 'Editar Perfil',
      'editProfileSaveButton': 'Guardar',
      'editProfileSaveChangesButton': 'Guardar Cambios',
      'editProfileUpdatedSuccess': 'Perfil actualizado con éxito',
      // Edit profile sections
      'editProfilePersonalInfoTitle': 'Información Personal',
      'editProfileContactInfoTitle': 'Datos de Contacto',
      'editProfileBeneficiaryInfoTitle': 'Información del Beneficiario',
      'editProfileNameLabel': 'Nombre',
      'editProfileLastNameLabel': 'Apellido',
      'editProfilePhoneLabel': 'Teléfono',
      'editProfileAddressLabel': 'Dirección',
      'editProfileBeneficiaryNameLabel': 'Nombre del Beneficiario',
      'editProfileBeneficiaryEmailLabel': 'Correo del Beneficiario',
      'editProfileBeneficiaryPhoneLabel': 'Teléfono del Beneficiario',
      // Purchases screen
      'purchasesTitle': 'Mis Compras',
      'purchasesExportPdfFunction': 'Función de exportar PDF no implementada.',
      'purchasesExportPdfTooltip': 'Exportar PDF',
      'purchasesExportButton': 'Exportar',
      'purchasesTotalPurchases': 'Total Compras',
      'purchasesExpenseLast30Days': 'Gasto (últ. 30 días)',
      'purchasesFiltersTitle': 'Filtros',
      'purchasesSearchPlaceholder': 'Buscar por No. Factura, Modelo...',
      'purchasesDateRangeHelp': 'Selecciona un rango de fechas',
      'purchasesDateRangeSave': 'Aplicar',
      'purchasesAnyDate': 'Cualquier fecha',
      'purchasesClearFiltersTooltip': 'Limpiar filtros',
      'purchasesNoResultsTitle': 'No se encontraron compras',
      'purchasesNoResultsSubtitle': 'Prueba ajustando los filtros o usando otro término de búsqueda.',
      'purchasesNoDetailsAvailable': 'Sin detalles disponibles',
      'purchasesStatusCompleted': 'Completado',
      'purchasesStatusReturned': 'Devuelto',
      // Wallet screen
      'walletTitle': 'Mi Billetera',
      'walletAvailable': 'Disponible',
      'walletEarned': 'Ganado',
      'walletTokens': 'Tokens',
      'walletRecentMovements': 'Movimientos Recientes',
      'walletFilterAll': 'Todos',
      'walletFilterIncome': 'Ingresos',
      'walletFilterExpenses': 'Gastos',
      'walletCredit': 'Crédito',
      'walletDebit': 'Débito',
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

  // Biometric prompt
  String get enableBiometricsTitle => _t('enableBiometricsTitle');

  String get enableBiometricsContent => _t('enableBiometricsContent');

  String get cancelButtonLabel => _t('cancelButtonLabel');

  String get enableButtonLabel => _t('enableButtonLabel');

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
  String get statsRecycoinTotal => _t('statsRecycoinTotal');

  String get statsBonusTokens => _t('statsBonusTokens');

  String get statsMonthlyCommission => _t('statsMonthlyCommission');

  String get statsReferrals => _t('statsReferrals');

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

  // Profile screen getters
  String get profileTitle => _t('profileTitle');

  String get profileErrorOccurred => _t('profileErrorOccurred');

  String get profileNoUserDataFound => _t('profileNoUserDataFound');

  String get profilePhotoUpdated => _t('profilePhotoUpdated');

  String get profileMainDataTitle => _t('profileMainDataTitle');

  String get profileSecondaryDataTitle => _t('profileSecondaryDataTitle');

  String get profileAdditionalDataTitle => _t('profileAdditionalDataTitle');

  String get profileUserLabel => _t('profileUserLabel');

  String get profileEmailLabel => _t('profileEmailLabel');

  String get profileIdentificationLabel => _t('profileIdentificationLabel');

  String get profileRegistrationDateLabel => _t('profileRegistrationDateLabel');

  String get profileBirthDateLabel => _t('profileBirthDateLabel');

  String get profileNameLabel => _t('profileNameLabel');

  String get profileLastNameLabel => _t('profileLastNameLabel');

  String get profileAddressLabel => _t('profileAddressLabel');

  String get profilePhoneLabel => _t('profilePhoneLabel');

  String get profileBeneficiaryNameLabel => _t('profileBeneficiaryNameLabel');

  String get profileBeneficiaryEmailLabel => _t('profileBeneficiaryEmailLabel');

  String get profileBeneficiaryPhoneLabel => _t('profileBeneficiaryPhoneLabel');

  String get profileNotSpecified => _t('profileNotSpecified');

  String get profileEditButton => _t('profileEditButton');

  String get profileLogoutButton => _t('profileLogoutButton');

  // Edit profile screen getters
  String get editProfileTitle => _t('editProfileTitle');

  String get editProfileSaveButton => _t('editProfileSaveButton');

  String get editProfileSaveChangesButton => _t('editProfileSaveChangesButton');

  String get editProfileUpdatedSuccess => _t('editProfileUpdatedSuccess');

  // Edit profile sections getters
  String get editProfilePersonalInfoTitle => _t('editProfilePersonalInfoTitle');

  String get editProfileContactInfoTitle => _t('editProfileContactInfoTitle');

  String get editProfileBeneficiaryInfoTitle => _t('editProfileBeneficiaryInfoTitle');

  String get editProfileNameLabel => _t('editProfileNameLabel');

  String get editProfileLastNameLabel => _t('editProfileLastNameLabel');

  String get editProfilePhoneLabel => _t('editProfilePhoneLabel');

  String get editProfileAddressLabel => _t('editProfileAddressLabel');

  String get editProfileBeneficiaryNameLabel => _t('editProfileBeneficiaryNameLabel');

  String get editProfileBeneficiaryEmailLabel => _t('editProfileBeneficiaryEmailLabel');

  String get editProfileBeneficiaryPhoneLabel => _t('editProfileBeneficiaryPhoneLabel');

  // Purchases screen getters
  String get purchasesTitle => _t('purchasesTitle');

  String get purchasesExportPdfFunction => _t('purchasesExportPdfFunction');

  String get purchasesExportPdfTooltip => _t('purchasesExportPdfTooltip');

  String get purchasesExportButton => _t('purchasesExportButton');

  String get purchasesTotalPurchases => _t('purchasesTotalPurchases');

  String get purchasesExpenseLast30Days => _t('purchasesExpenseLast30Days');

  String get purchasesFiltersTitle => _t('purchasesFiltersTitle');

  String get purchasesSearchPlaceholder => _t('purchasesSearchPlaceholder');

  String get purchasesDateRangeHelp => _t('purchasesDateRangeHelp');

  String get purchasesDateRangeSave => _t('purchasesDateRangeSave');

  String get purchasesAnyDate => _t('purchasesAnyDate');

  String get purchasesClearFiltersTooltip => _t('purchasesClearFiltersTooltip');

  String get purchasesNoResultsTitle => _t('purchasesNoResultsTitle');

  String get purchasesNoResultsSubtitle => _t('purchasesNoResultsSubtitle');

  String get purchasesNoDetailsAvailable => _t('purchasesNoDetailsAvailable');

  String get purchasesStatusCompleted => _t('purchasesStatusCompleted');

  String get purchasesStatusReturned => _t('purchasesStatusReturned');

  // Wallet screen getters
  String get walletTitle => _t('walletTitle');

  String get walletAvailable => _t('walletAvailable');

  String get walletEarned => _t('walletEarned');

  String get walletTokens => _t('walletTokens');

  String get walletRecentMovements => _t('walletRecentMovements');

  String get walletFilterAll => _t('walletFilterAll');

  String get walletFilterIncome => _t('walletFilterIncome');

  String get walletFilterExpenses => _t('walletFilterExpenses');

  String get walletCredit => _t('walletCredit');

  String get walletDebit => _t('walletDebit');
}
