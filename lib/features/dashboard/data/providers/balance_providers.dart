import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/providers/api_providers.dart';
import 'package:my_app/features/dashboard/data/repositories/balance_repository_impl.dart';
import 'package:my_app/features/dashboard/domain/repositories/balance_repository.dart';
import 'package:my_app/features/dashboard/domain/use_cases/get_balance_information_use_case.dart';

final balanceRepositoryProvider = Provider<BalanceRepository>(
  (ref) => BalanceRepositoryImpl(ref.watch(walletServiceProvider)),
);

final getBalanceInformationUseCaseProvider =
    Provider<GetBalanceInformationUseCase>((ref) {
      final balanceRepository = ref.watch(balanceRepositoryProvider);
      return GetBalanceInformationUseCase(balanceRepository);
    });
