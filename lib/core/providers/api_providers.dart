import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/services/api/affiliate_service.dart';
import 'package:my_app/core/services/api/auth_service.dart';
import 'package:my_app/core/services/api/configuration_service.dart';
import 'package:my_app/core/services/api/invoice_service.dart';
import 'package:my_app/core/services/api/matrix_service.dart';
import 'package:my_app/core/services/api/wallet_request_service.dart';
import 'package:my_app/core/services/api/wallet_service.dart';

// =============================================================================
// API SERVICES
// =============================================================================

final authServiceProvider = Provider<AuthService>(
  (ref) => AuthService(),
);

final walletServiceProvider = Provider<WalletService>(
  (ref) => WalletService(),
);

final configurationServiceProvider = Provider<ConfigurationService>(
  (ref) => ConfigurationService(),
);

final invoiceServiceProvider = Provider<InvoiceService>(
  (ref) => InvoiceService(),
);

final affiliateServiceProvider = Provider<AffiliateService>(
  (ref) => AffiliateService(),
);

final matrixServiceProvider = Provider<MatrixService>(
  (ref) => MatrixService(),
);

final walletRequestServiceProvider = Provider<WalletRequestService>(
  (ref) => WalletRequestService(),
);
