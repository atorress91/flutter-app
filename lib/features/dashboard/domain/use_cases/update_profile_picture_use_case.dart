import 'package:my_app/core/services/platform/image_picker_service.dart';
import 'package:my_app/features/auth/domain/entities/user.dart';
import '../repositories/profile_repository.dart';

class UpdateProfilePictureUseCase {
  final ImagePickerService _imagePickerService;
  final ProfileRepository _profileRepository;

  UpdateProfilePictureUseCase(
    this._imagePickerService,
    this._profileRepository,
  );

  Future<User?> execute(User currentUser) async {
    final imageFile = await _imagePickerService.pickImageFromGallery();
    if (imageFile == null) return null;

    final downloadURL = await _profileRepository.uploadProfileImage(
      imageFile,
      currentUser,
    );
    return User(
      id: currentUser.id,
      userName: currentUser.userName,
      email: currentUser.email,
      fullName: currentUser.fullName,
      imageUrl: downloadURL,
      isActive: currentUser.isActive,
      createdAt: currentUser.createdAt,
      roleName: currentUser.roleName,
      phone: currentUser.phone,
      isAffiliate: currentUser.isAffiliate,
    );
  }
}
