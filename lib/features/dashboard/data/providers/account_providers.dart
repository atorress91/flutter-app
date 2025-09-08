import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/providers/api_providers.dart';
import 'package:my_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:my_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:my_app/features/auth/domain/use_cases/perform_login_use_case.dart';
import 'package:my_app/features/auth/domain/use_cases/perform_registration_use_case.dart';

// --- REPOSITORIES ---
final authRepositoryProvider = Provider<AuthRepository>(
      (ref) => AuthRepositoryImpl(ref.watch(authServiceProvider)),
);

// --- USE CASES ---
final performLoginUseCaseProvider = Provider<PerformLoginUseCase>(
      (ref) => PerformLoginUseCase(),
);

final performRegistrationUseCaseProvider = Provider<PerformRegistrationUseCase>(
      (ref) => PerformRegistrationUseCase(),
);
