import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/providers/api_providers.dart';
import 'package:my_app/features/dashboard/data/repositories/configuration_repository_impl.dart';
import 'package:my_app/features/dashboard/domain/repositories/configuration_repository.dart';
import 'package:my_app/features/dashboard/domain/use_cases/get_withdrawal_wallet_configuration_use_case.dart';

// --- REPOSITORIES ---
final configurationRepositoryProvider = Provider<ConfigurationRepository>(
  (ref) => ConfigurationRepositoryImpl(ref.watch(configurationServiceProvider)),
);

// --- USE CASES ---
final getWithdrawalWalletConfigurationUseCaseProvider = Provider(
  (ref) => GetWithdrawalWalletConfigurationUseCase(ref.watch(configurationRepositoryProvider)),
);

