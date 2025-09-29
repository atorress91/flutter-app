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
      // Clients screen
      'clientsTitle': 'My Clients',
      'clientsAddClientTooltip': 'Add Client',
      'clientsAddButton': 'Add',
      'clientsDirect': 'Direct Clients',
      'clientsIndirect': 'Indirect Clients',
      'clientsUniLevel': 'UniLevel',
      'clientsNoDirectClients': "You don't have direct clients yet.",
      'clientsExpand': 'Expand',
      'clientsCollapse': 'Collapse',
            'clientsZoomIn': 'Zoom in',
            'clientsZoomOut': 'Zoom out',
            'clientsResetView': 'Reset view',
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
      // Sidebar
      'sidebarHome': 'Home',
      'sidebarPurchases': 'My Purchases',
      'sidebarClients': 'My Clients',
      'sidebarRequestPayment': 'Request Payment',
      'sidebarMyWallet': 'My Wallet',
      'sidebarCustomerService': 'Customer Service',
      'sidebarLogout': 'Log Out',
      // Auth form
      'passwordLabel': 'Password',
      'signInButtonLabel': 'Sign in',
      'usernameOrEmailLabel': 'Username or email',
      'usernameOrEmailRequired': 'Enter your username or email',
      'passwordRequired': 'Enter your password',
      'passwordTooShort': 'Password is too short',
      'showPassword': 'Show password',
      'hidePassword': 'Hide password',
      'forgotPassword': 'Forgot your password?',
      'forgotPasswordSoon': 'Password recovery coming soon',
      'loginOrContinueWith': 'or continue with',
      'noAccountQuestion': "Don't have an account? ",
      'createAccount': 'Create Account',
      'invalidCredentials': 'Invalid username or password.',
      'signInWithBiometrics': 'Sign in with fingerprint',
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
      'homeBalancesTitle': 'Recycoin Balances',
      'homeContractDetailsTitle': 'Contract Details',
      'homeErrorLoadingBalance': 'Error loading balance:',
      // Contract details
      'contractLabel': 'Contract',
      'publicSaleLabel': 'Public sale',
      'networkLabel': 'Network',
      'contractCopied': 'Contract copied to clipboard',
      // Months short
      'monthJanShort': 'Jan',
      'monthFebShort': 'Feb',
      'monthMarShort': 'Mar',
      'monthAprShort': 'Apr',
      'monthMayShort': 'May',
      'monthJunShort': 'Jun',
      'monthJulShort': 'Jul',
      'monthAugShort': 'Aug',
      'monthSepShort': 'Sep',
      'monthOctShort': 'Oct',
      'monthNovShort': 'Nov',
      'monthDecShort': 'Dec',
      // Balance chart labels
      'balanceAvailable': 'Available',
      'balancePaid': 'Paid',
      'balanceRecycoins': 'Recycoins',
      'balanceTotal': 'Total Balance',
      // Stats
      'statsRecycoinTotal': 'Total Recycoin',
      'statsBonusTokens': 'Bonus Tokens',
      'statsMonthlyCommission': 'Commission',
      'statsReferrals': 'Referrals',
      // Quick actions
      'quickCreate': 'Create',
      'quickClients': 'Clients',
      'quickInvoices': 'Invoices',
      'quickMyWallet': 'Movements',
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
      // Request Payment screen
      'requestPaymentTitle': 'Request Payment',
      'requestPaymentNewRequestButton': 'Create New Request',
      'requestPaymentHistoryTitle': 'Request History',
      'requestPaymentMinimumAmountInfoPrefix': 'The minimum amount to process the payment is USD \$',
      'requestPaymentWalletAvailableLabel': 'Available Wallet Balance:',
      // New Payment Request Modal
      'requestPaymentModalTitle': 'Send Request',
      'requestPaymentAmountLabel': 'Requested Amount *',
      'formRequiredField': 'Required field',
      'requestPaymentAccessKeyLabel': 'Access key *',
      'requestPaymentObservationLabel': 'Observation',
      'requestPaymentConfirmationCodeLabel': 'Confirmation code *',
      'requestPaymentSendCodeButton': 'Send code',
      'requestPaymentConfirmAndSendButton': 'Confirm and Send',
      'requestPaymentCodeSendSuccess': 'Code sent to your device.',
      'requestPaymentCodeSendError': 'Error sending the code.',
      'requestPaymentSubmitSuccess': 'Request sent successfully',
      'requestPaymentSubmitError': 'An error occurred while sending the request',
      'requestPaymentNoPreviousRequests': "You don't have previous requests.",
      'requestPaymentObservation': 'Observation:',
      'requestPaymentResponse': 'Response:',
      'requestPaymentDate': 'Date:',
      'requestPaymentStatusApproved': 'Approved',
      'requestPaymentStatusPending': 'Pending',
      'requestPaymentStatusRejected': 'Rejected',
      // New payment request types
      'requestPaymentTypeWithdrawalRequest': 'Withdrawal Request',
    },
    'es': {
      // Clients screen
      'clientsTitle': 'Mis Clientes',
      'clientsAddClientTooltip': 'Añadir Cliente',
      'clientsAddButton': 'Añadir',
      'clientsDirect': 'Clientes Directos',
      'clientsIndirect': 'Clientes Indirectos',
      'clientsUniLevel': 'UniLevel',
      'clientsNoDirectClients': 'Aún no tienes clientes directos.',
      'clientsExpand': 'Expandir',
      'clientsCollapse': 'Contraer',
            'clientsZoomIn': 'Acercar',
            'clientsZoomOut': 'Alejar',
            'clientsResetView': 'Restablecer vista',
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
      // Sidebar
      'sidebarHome': 'Inicio',
      'sidebarPurchases': 'Mis Compras',
      'sidebarClients': 'Mis Clientes',
      'sidebarRequestPayment': 'Solicitar pago',
      'sidebarMyWallet': 'Mi Billetera',
      'sidebarCustomerService': 'Servicio al cliente',
      'sidebarLogout': 'Cerrar Sesión',
      // Auth form
      'passwordLabel': 'Contraseña',
      'signInButtonLabel': 'Iniciar sesión',
      'usernameOrEmailLabel': 'Usuario o email',
      'usernameOrEmailRequired': 'Ingresa tu usuario o email',
      'passwordRequired': 'Ingresa tu contraseña',
      'passwordTooShort': 'La contraseña es muy corta',
      'showPassword': 'Mostrar contraseña',
      'hidePassword': 'Ocultar contraseña',
      'forgotPassword': '¿Olvidaste tu contraseña?',
      'forgotPasswordSoon': 'Función de recuperación de contraseña próximamente',
      'loginOrContinueWith': 'o continúa con',
      'noAccountQuestion': '¿No tienes cuenta? ',
      'createAccount': 'Crear Cuenta',
      'invalidCredentials': 'Usuario o contraseña inválidos.',
      'signInWithBiometrics': 'Iniciar sesión con huella',
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
      'homeBalancesTitle': 'Balances Recycoin',
      'homeContractDetailsTitle': 'Detalles del Contrato',
      'homeErrorLoadingBalance': 'Error al cargar el balance:',
      // Contract details
      'contractLabel': 'Contrato',
      'publicSaleLabel': 'Venta pública',
      'networkLabel': 'Red',
      'contractCopied': 'Contrato copiado al portapapeles',
      // Months short
      'monthJanShort': 'Ene',
      'monthFebShort': 'Feb',
      'monthMarShort': 'Mar',
      'monthAprShort': 'Abr',
      'monthMayShort': 'May',
      'monthJunShort': 'Jun',
      'monthJulShort': 'Jul',
      'monthAugShort': 'Ago',
      'monthSepShort': 'Sep',
      'monthOctShort': 'Oct',
      'monthNovShort': 'Nov',
      'monthDecShort': 'Dic',
      // Balance chart labels
      'balanceAvailable': 'Disponible',
      'balancePaid': 'Pagado',
      'balanceRecycoins': 'Recycoins',
      'balanceTotal': 'Balance Total',
      // Stats
      'statsRecycoinTotal': 'Recycoin totales',
      'statsBonusTokens': 'Bonos tokens',
      'statsMonthlyCommission': 'Comisión mensual',
      'statsReferrals': 'Referidos',
      // Quick actions
      'quickCreate': 'Retirar',
      'quickClients': 'Clientes',
      'quickInvoices': 'Facturas',
      'quickMyWallet': 'Movimientos',
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
      // Request Payment screen
      'requestPaymentTitle': 'Realizar solicitud de pago',
      'requestPaymentNewRequestButton': 'Realizar Nueva Solicitud',
      'requestPaymentHistoryTitle': 'Historial de Solicitudes',
      'requestPaymentMinimumAmountInfoPrefix': 'El monto mínimo para procesar el pago es de USD \$',
      'requestPaymentWalletAvailableLabel': 'Saldo Disponible en Billetera:',
      // New Payment Request Modal
      'requestPaymentModalTitle': 'Enviar Solicitud',
      'requestPaymentAmountLabel': 'Monto que Solicita *',
      'formRequiredField': 'Campo requerido',
      'requestPaymentAccessKeyLabel': 'Clave de acceso *',
      'requestPaymentObservationLabel': 'Observación',
      'requestPaymentConfirmationCodeLabel': 'Código de confirmación *',
      'requestPaymentSendCodeButton': 'Enviar código',
      'requestPaymentConfirmAndSendButton': 'Confirmar y Enviar',
      'requestPaymentCodeSendSuccess': 'Código enviado a tu dispositivo.',
      'requestPaymentCodeSendError': 'Error al enviar el código.',
      'requestPaymentSubmitSuccess': 'Solicitud enviada con éxito',
      'requestPaymentSubmitError': 'Ocurrió un error al enviar la solicitud',
      'requestPaymentNoPreviousRequests': 'No tienes solicitudes anteriores.',
      'requestPaymentObservation': 'Observación:',
      'requestPaymentResponse': 'Respuesta:',
      'requestPaymentDate': 'Fecha:',
      'requestPaymentStatusApproved': 'Aprobado',
      'requestPaymentStatusPending': 'Pendiente',
      'requestPaymentStatusRejected': 'Rechazado',
      // Nuevos tipos de solicitud de pago
      'requestPaymentTypeWithdrawalRequest': 'Solicitud de retiro',
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

  String get quickClients => _t('quickClients');

  String get quickInvoices => _t('quickInvoices');

  String get quickMyWallet => _t('quickMyWallet');

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

  // Request Payment screen getters
  String get requestPaymentTitle => _t('requestPaymentTitle');

  String get requestPaymentNewRequestButton => _t('requestPaymentNewRequestButton');

  String get requestPaymentHistoryTitle => _t('requestPaymentHistoryTitle');

  String get requestPaymentMinimumAmountInfoPrefix => _t('requestPaymentMinimumAmountInfoPrefix');

  String get requestPaymentWalletAvailableLabel => _t('requestPaymentWalletAvailableLabel');

  // New Payment Request Modal getters
  String get requestPaymentModalTitle => _t('requestPaymentModalTitle');

  String get requestPaymentAmountLabel => _t('requestPaymentAmountLabel');

  String get formRequiredField => _t('formRequiredField');

  String get requestPaymentAccessKeyLabel => _t('requestPaymentAccessKeyLabel');

  String get requestPaymentObservationLabel => _t('requestPaymentObservationLabel');

  String get requestPaymentConfirmationCodeLabel => _t('requestPaymentConfirmationCodeLabel');

  String get requestPaymentSendCodeButton => _t('requestPaymentSendCodeButton');

  String get requestPaymentConfirmAndSendButton => _t('requestPaymentConfirmAndSendButton');

  String get requestPaymentCodeSendSuccess => _t('requestPaymentCodeSendSuccess');

  String get requestPaymentCodeSendError => _t('requestPaymentCodeSendError');

  String get requestPaymentSubmitSuccess => _t('requestPaymentSubmitSuccess');

  String get requestPaymentSubmitError => _t('requestPaymentSubmitError');

  String get requestPaymentNoPreviousRequests => _t('requestPaymentNoPreviousRequests');
  String get requestPaymentObservation => _t('requestPaymentObservation');
  String get requestPaymentResponse => _t('requestPaymentResponse');
  String get requestPaymentDate => _t('requestPaymentDate');
  String get requestPaymentStatusApproved => _t('requestPaymentStatusApproved');
  String get requestPaymentStatusPending => _t('requestPaymentStatusPending');
  String get requestPaymentStatusRejected => _t('requestPaymentStatusRejected');
  String get requestPaymentTypeWithdrawalRequest => _t('requestPaymentTypeWithdrawalRequest');
}
