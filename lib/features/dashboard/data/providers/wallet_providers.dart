import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/providers/api_providers.dart';
import 'package:my_app/features/dashboard/data/repositories/balance_repository_impl.dart';
import 'package:my_app/features/dashboard/data/repositories/invoice_repository_impl.dart';
import 'package:my_app/features/dashboard/data/repositories/network_purchase_repository_impl.dart';
import 'package:my_app/features/dashboard/data/repositories/wallet_repository_impl.dart';
import 'package:my_app/features/dashboard/domain/repositories/balance_repository.dart';
import 'package:my_app/features/dashboard/domain/repositories/invoice_repository.dart';
import 'package:my_app/features/dashboard/domain/repositories/network_purchase_repository.dart';
import 'package:my_app/features/dashboard/domain/repositories/wallet_repository.dart';
import 'package:my_app/features/dashboard/domain/use_cases/get_balance_information_use_case.dart';
import 'package:my_app/features/dashboard/domain/use_cases/get_invoices_use_case.dart';
import 'package:my_app/features/dashboard/domain/use_cases/get_network_purchases_use_case.dart';
import 'package:my_app/features/dashboard/domain/use_cases/get_wallet_transactions_use_case.dart';

// --- REPOSITORIES ---
final balanceRepositoryProvider = Provider<BalanceRepository>(
      (ref) => BalanceRepositoryImpl(ref.watch(walletServiceProvider)),
);

final invoiceRepositoryProvider = Provider<InvoiceRepository>(
      (ref) => InvoiceRepositoryImpl(ref.watch(invoiceServiceProvider)),
);

final networkPurchaseRepositoryProvider = Provider<NetworkPurchaseRepository>(
      (ref) => NetworkPurchaseRepositoryImpl(ref.watch(walletServiceProvider)),
);

final walletRepositoryProvider = Provider<WalletRepository>(
      (ref) => WalletRepositoryImpl(ref.watch(walletServiceProvider)),
);

// --- USE CASES ---
final getBalanceInformationUseCaseProvider = Provider<GetBalanceInformationUseCase>((ref) =>
    GetBalanceInformationUseCase(ref.watch(balanceRepositoryProvider))
);

final getInvoicesUseCaseProvider = Provider<GetInvoicesUseCase>((ref) =>
    GetInvoicesUseCase(ref.watch(invoiceRepositoryProvider))
);

final getNetworkPurchasesUseCaseProvider = Provider<GetNetworkPurchasesUseCase>((ref) =>
    GetNetworkPurchasesUseCase(ref.watch(networkPurchaseRepositoryProvider))
);

final getWalletTransactionsUseCaseProvider = Provider<GetWalletTransactionsUseCase>((ref) =>
    GetWalletTransactionsUseCase(ref.watch(walletRepositoryProvider))
);
