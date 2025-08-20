import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/services/api/wallet_service.dart';
import 'package:my_app/features/dashboard/data/repositories/balance_repository_impl.dart';
import 'package:my_app/features/dashboard/domain/repositories/balance_repository.dart';
import 'package:my_app/features/dashboard/domain/use_cases/get_balance_information_use_case.dart';
import 'package:my_app/features/dashboard/presentation/controllers/balance_controller.dart';
import 'package:my_app/features/dashboard/domain/entities/balance_state.dart';

final walletServiceProvider = Provider<WalletService>((ref) => WalletService());

final balanceRepositoryProvider = Provider<BalanceRepository>(
      (ref) => BalanceRepositoryImpl(ref.watch(walletServiceProvider)),
);

final getBalanceInformationUseCaseProvider = Provider<GetBalanceInformationUseCase>(
      (ref) => GetBalanceInformationUseCase(ref),
);

final balanceControllerProvider = StateNotifierProvider<BalanceController, BalanceState>(
      (ref) => BalanceController(ref),
);