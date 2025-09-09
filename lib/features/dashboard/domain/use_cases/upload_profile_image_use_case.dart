
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/features/auth/domain/entities/user.dart';
import 'package:my_app/features/dashboard/data/providers/account_providers.dart';


class UploadProfileImageUseCase {
  final ProfileRepository _profileRepository;

  UploadProfileImageUseCase(this._profileRepository);

  Future<String> execute(File imageFile, User user) async {
    return await _profileRepository.uploadProfileImage(imageFile, user);
  }
}

final uploadProfileImageUseCaseProvider = Provider<UploadProfileImageUseCase>((ref) {
  final profileRepository = ref.watch(profileRepositoryProvider);
  return UploadProfileImageUseCase(profileRepository);
});