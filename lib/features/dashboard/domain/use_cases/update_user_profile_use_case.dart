import 'package:my_app/features/auth/domain/entities/user.dart';
import 'package:my_app/features/dashboard/domain/repositories/profile_repository.dart';

class UpdateUserProfileUseCase {
  final ProfileRepository _profileRepository;

  UpdateUserProfileUseCase(this._profileRepository);

  Future<User> execute(User currentUser) async {
    return await _profileRepository.updateUserProfile(currentUser);
  }
}
