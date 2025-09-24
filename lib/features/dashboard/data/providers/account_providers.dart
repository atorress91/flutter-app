import 'package:flutter_riverpod/flutter_riverpod.dart';
// Core providers and services
import 'package:my_app/core/providers/api_providers.dart';
import 'package:my_app/core/services/api/affiliate_service.dart';
import 'package:my_app/core/services/api/matrix_service.dart';
import 'package:my_app/core/services/api/wallet_request_service.dart';
import 'package:my_app/core/services/platform/firebase_storage_service.dart';
import 'package:my_app/core/services/platform/image_picker_service.dart';

// Auth feature imports
import 'package:my_app/features/auth/data/repositories/affiliate_repository_impl.dart';
import 'package:my_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:my_app/features/auth/domain/repositories/affiliate_repository.dart';
import 'package:my_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:my_app/features/auth/domain/use_cases/get_current_user_use_case.dart';
import 'package:my_app/features/auth/domain/use_cases/perform_login_use_case.dart';
import 'package:my_app/features/auth/domain/use_cases/perform_registration_use_case.dart';

// Dashboard feature imports
import 'package:my_app/features/dashboard/data/repositories/matrix_repository_impl.dart';
import 'package:my_app/features/dashboard/data/repositories/profile_repository_impl.dart';
import 'package:my_app/features/dashboard/data/repositories/request_repository_impl.dart';
import 'package:my_app/features/dashboard/domain/repositories/matrix_repository.dart';
import 'package:my_app/features/dashboard/domain/repositories/profile_repository.dart';
import 'package:my_app/features/dashboard/domain/repositories/request_repository.dart';
import 'package:my_app/features/dashboard/domain/use_cases/generate_verification_code_use_case.dart';
import 'package:my_app/features/dashboard/domain/use_cases/get_unilevel_tree_use_case.dart';
import 'package:my_app/features/dashboard/domain/use_cases/update_profile_picture_use_case.dart';
import 'package:my_app/features/dashboard/domain/use_cases/update_user_profile_use_case.dart';

// =============================================================================
// SERVICES
// =============================================================================

final affiliateServiceProvider = Provider<AffiliateService>(
  (ref) => AffiliateService(),
);

final walletRequestServiceProvider = Provider<WalletRequestService>(
  (ref) => WalletRequestService(),
);

// =============================================================================
// REPOSITORIES
// =============================================================================

// --- Auth Repositories ---
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.watch(authServiceProvider)),
);

final affiliateRepositoryProvider = Provider<AffiliateRepository>(
  (ref) => AffiliateRepositoryImpl(ref.watch(affiliateServiceProvider)),
);

// --- Dashboard Repositories ---
final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepositoryImpl(
    ref.watch(firebaseStorageServiceProvider),
    ref.watch(affiliateServiceProvider),
  ),
);

final matrixRepositoryProvider = Provider<MatrixRepository>(
  (ref) => MatrixRepositoryImpl(MatrixService()),
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

// --- Auth Use Cases ---
final performLoginUseCaseProvider = Provider<PerformLoginUseCase>(
  (ref) => PerformLoginUseCase(),
);

final performRegistrationUseCaseProvider = Provider<PerformRegistrationUseCase>(
  (ref) => PerformRegistrationUseCase(),
);

final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>(
  (ref) => GetCurrentUserUseCase(
    ref.watch(affiliateRepositoryProvider),
  ),
);

// --- Profile Use Cases ---
final updateProfilePictureUseCaseProvider = Provider<UpdateProfilePictureUseCase>(
  (ref) => UpdateProfilePictureUseCase(
    ref.watch(imagePickerServiceProvider),
    ref.watch(profileRepositoryProvider),
  ),
);

final updateUserProfileUseCaseProvider = Provider<UpdateUserProfileUseCase>(
  (ref) => UpdateUserProfileUseCase(
    ref.watch(profileRepositoryProvider),
  ),
);

// --- Matrix Use Cases ---
final getUniLevelTreeUseCaseProvider = Provider<GetUniLevelTreeUseCase>(
  (ref) => GetUniLevelTreeUseCase(ref.watch(matrixRepositoryProvider)),
);

// --- Request Use Cases ---
final generateVerificationCodeUseCaseProvider = Provider<GenerateVerificationCodeUseCase>(
  (ref) => GenerateVerificationCodeUseCase(ref.watch(requestRepositoryProvider)),
);