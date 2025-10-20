import 'package:flutter_riverpod/flutter_riverpod.dart';

// Core providers
import 'package:my_app/core/providers/api_providers.dart';
import 'package:my_app/core/providers/platform_providers.dart';

// Dashboard repositories
import 'package:my_app/features/dashboard/data/repositories/matrix_repository_impl.dart';
import 'package:my_app/features/dashboard/data/repositories/profile_repository_impl.dart';
import 'package:my_app/features/dashboard/data/repositories/request_repository_impl.dart';
import 'package:my_app/features/dashboard/domain/repositories/matrix_repository.dart';
import 'package:my_app/features/dashboard/domain/repositories/profile_repository.dart';
import 'package:my_app/features/dashboard/domain/repositories/request_repository.dart';

// Dashboard use cases
import 'package:my_app/features/dashboard/domain/use_cases/create_wallet_request_use_case.dart';
import 'package:my_app/features/dashboard/domain/use_cases/generate_verification_code_use_case.dart';
import 'package:my_app/features/dashboard/domain/use_cases/get_unilevel_tree_use_case.dart';
import 'package:my_app/features/dashboard/domain/use_cases/get_wallet_request_use_case.dart';
import 'package:my_app/features/dashboard/domain/use_cases/has_reached_withdrawal_limit_use_case.dart';
import 'package:my_app/features/dashboard/domain/use_cases/update_profile_picture_use_case.dart';
import 'package:my_app/features/dashboard/domain/use_cases/update_user_profile_use_case.dart';

// =============================================================================
// REPOSITORIES
// =============================================================================

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepositoryImpl(
    ref.watch(firebaseStorageServiceProvider),
    ref.watch(affiliateServiceProvider),
  ),
);

final matrixRepositoryProvider = Provider<MatrixRepository>(
  (ref) => MatrixRepositoryImpl(ref.watch(matrixServiceProvider)),
);

final requestRepositoryProvider = Provider<RequestRepository>(
  (ref) => RequestRepositoryImpl(
    ref.watch(walletRequestServiceProvider),
    ref.watch(affiliateServiceProvider),
  ),
);

// =============================================================================
// USE CASES
// =============================================================================

// --- Profile Use Cases ---

final updateProfilePictureUseCaseProvider = Provider<UpdateProfilePictureUseCase>(
  (ref) => UpdateProfilePictureUseCase(
    ref.watch(imagePickerServiceProvider),
    ref.watch(profileRepositoryProvider),
  ),
);

final updateUserProfileUseCaseProvider = Provider<UpdateUserProfileUseCase>(
  (ref) => UpdateUserProfileUseCase(ref.watch(profileRepositoryProvider)),
);

// --- Matrix Use Cases ---

final getUniLevelTreeUseCaseProvider = Provider<GetUniLevelTreeUseCase>(
  (ref) => GetUniLevelTreeUseCase(ref.watch(matrixRepositoryProvider)),
);
final hasReachedWithdrawalLimitUseCaseProvider = Provider<HasReachedWithdrawalLimitUseCase>(
  (ref) => HasReachedWithdrawalLimitUseCase(ref.watch(matrixRepositoryProvider)),
);


// --- Request Use Cases ---

final generateVerificationCodeUseCaseProvider = Provider<GenerateVerificationCodeUseCase>(
  (ref) => GenerateVerificationCodeUseCase(ref.watch(requestRepositoryProvider)),
);

final createWalletRequestUseCaseProvider = Provider.autoDispose<CreateWalletRequestUseCase>(
  (ref) => CreateWalletRequestUseCase(ref.watch(requestRepositoryProvider)),
);

final getWalletRequestUseCaseProvider = Provider<GetWalletRequestUseCase>(
  (ref) => GetWalletRequestUseCase(ref.watch(requestRepositoryProvider)),
);
