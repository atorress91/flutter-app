import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/providers/api_providers.dart';
import 'package:my_app/features/dashboard/data/repositories/wallet_repository_impl.dart';
import 'package:my_app/features/dashboard/domain/repositories/wallet_repository.dart';
import 'package:my_app/features/dashboard/domain/use_cases/get_wallet_transactions_use_case.dart';

final walletRepositoryProvider = Provider<WalletRepository>(
      (ref) => WalletRepositoryImpl(ref.watch(walletServiceProvider)),
);

final getWalletTransactionsUseCaseProvider = Provider<GetWalletTransactionsUseCase>(
      (ref) {
    final walletRepository = ref.watch(walletRepositoryProvider);
    return GetWalletTransactionsUseCase(walletRepository);
  },
);
