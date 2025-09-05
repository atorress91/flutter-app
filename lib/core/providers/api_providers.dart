import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/services/api/auth_service.dart';
import 'package:my_app/core/services/api/invoice_service.dart';
import 'package:my_app/core/services/api/wallet_service.dart';

final walletServiceProvider = Provider<WalletService>((ref) => WalletService());
final authServiceProvider = Provider<AuthService>((ref) => AuthService());
final invoiceServiceProvider = Provider<InvoiceService>((ref) => InvoiceService());