import 'dart:io';
import 'package:my_app/core/data/request/update_user_profile_request.dart';
import 'package:my_app/core/services/api/affiliate_service.dart';
import 'package:my_app/core/services/platform/firebase_storage_service.dart';
import 'package:my_app/features/auth/data/mappers/user_mapper.dart';
import 'package:my_app/features/auth/domain/entities/user.dart';
import 'package:my_app/core/data/request/update_image_request.dart';
import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/features/dashboard/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final FirebaseStorageService _storageService;
  final AffiliateService _affiliateService;

  ProfileRepositoryImpl(this._storageService, this._affiliateService);

  @override
  Future<String> uploadProfileImage(File imageFile, User user) async {
    return _storageService.uploadProfileImage(imageFile, user);
  }

  @override
  Future<User> updateProfileImage(User user) async {
    final request = UpdateImageRequest(
      imageProfileUrl: user.imageUrl ?? '',
    );
    final response = await _affiliateService.updateImage(user.id, request);

    if (response.success && response.data != null) {
      return UserMapper.fromDto(response.data!);
    } else {
      throw ApiException(response.message ?? 'Error al actualizar el usuario');
    }
  }

  @override
  Future<User> updateUserProfile(User user) async {
    final request = UpdateUserProfileRequest(
      identification: user.identification,
      binaryMatrixSide: 1,
      phone: user.phone ?? '',
      address: user.address,
      beneficiaryName: user.beneficiaryName,
      beneficiaryEmail: user.beneficiaryEmail,
      beneficiaryPhone: user.beneficiaryPhone,
    );
    final response = await _affiliateService.updateUserProfile(user.id, request);

    if (response.success && response.data != null) {
      return UserMapper.fromDto(response.data!);
    } else {
      throw ApiException(
          response.message ?? 'Error al actualizar el perfil del usuario');
    }
  }
}

