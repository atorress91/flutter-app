import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:my_app/features/dashboard/domain/use_cases/upload_profile_image_use_case.dart';
import 'package:my_app/features/dashboard/domain/use_cases/update_profile_image_url_use_case.dart';

final profileScreenControllerProvider = Provider((ref) {
  return ProfileScreenController(ref);
});

class ProfileScreenController {
  final Ref _ref;

  ProfileScreenController(this._ref);

  Future<void> updateProfilePicture() async {
    final user = _ref.read(authNotifierProvider).value?.user;
    if (user == null) {
      throw Exception('Debes iniciar sesión.');
    }

    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);

      final uploadUseCase = _ref.read(uploadProfileImageUseCaseProvider);
      final downloadURL = await uploadUseCase.execute(file, user);

      final updateUrlUseCase = _ref.read(updateProfileImageUrlUseCaseProvider);
      await updateUrlUseCase.execute(user.id, downloadURL);

      await _ref.read(authNotifierProvider.notifier).reloadFromStorage();
    }
  }
}