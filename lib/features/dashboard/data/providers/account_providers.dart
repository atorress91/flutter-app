import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/providers/api_providers.dart';
import 'package:my_app/core/services/api/affiliate_service.dart';
import 'package:my_app/core/services/platform/firebase_storage_service.dart';
import 'package:my_app/core/services/platform/image_picker_service.dart';
import 'package:my_app/features/auth/data/repositories/affiliate_repository_impl.dart';
import 'package:my_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:my_app/features/auth/domain/repositories/affiliate_repository.dart';
import 'package:my_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:my_app/features/auth/domain/use_cases/get_current_user_use_case.dart';
import 'package:my_app/features/auth/domain/use_cases/perform_login_use_case.dart';
import 'package:my_app/features/auth/domain/use_cases/perform_registration_use_case.dart';
import 'package:my_app/features/dashboard/data/repositories/profile_repository_impl.dart';
import 'package:my_app/features/dashboard/domain/repositories/profile_repository.dart';
import 'package:my_app/features/dashboard/domain/use_cases/update_profile_picture_use_case.dart';
import 'package:my_app/features/dashboard/domain/use_cases/update_user_profile_use_case.dart';

// --- REPOSITORIES ---
final authRepositoryProvider = Provider<AuthRepository>(
     (ref) => AuthRepositoryImpl(ref.watch(authServiceProvider)),
);

final affiliateRepositoryProvider = Provider<AffiliateRepository>(
     (ref) => AffiliateRepositoryImpl(ref.watch(affiliateServiceProvider)),
);

final profileRepositoryProvider = Provider<ProfileRepository>(
     (ref) => ProfileRepositoryImpl(
       ref.watch(firebaseStorageServiceProvider),
       ref.watch(affiliateServiceProvider),
     ),
);

final affiliateServiceProvider = Provider((ref) => AffiliateService());

// --- USE CASES ---
final performLoginUseCaseProvider = Provider<PerformLoginUseCase>(
      (ref) => PerformLoginUseCase(),
);

final performRegistrationUseCaseProvider = Provider<PerformRegistrationUseCase>(
      (ref) => PerformRegistrationUseCase(),
);

final updateProfilePictureUseCaseProvider = Provider<UpdateProfilePictureUseCase>(
      (ref) => UpdateProfilePictureUseCase(
        ref.watch(imagePickerServiceProvider),
        ref.watch(profileRepositoryProvider),
      ),
);

final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>(
      (ref) => GetCurrentUserUseCase(
        ref.watch(affiliateRepositoryProvider),
      ),
);

final updateUserProfileUseCaseProvider = Provider<UpdateUserProfileUseCase>(
      (ref) => UpdateUserProfileUseCase(
        ref.watch(profileRepositoryProvider),
      ),
);
