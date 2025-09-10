import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/data/request/update_image_request.dart';
import 'package:my_app/core/services/api/affiliate_service.dart';
import 'package:my_app/features/auth/domain/entities/user.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage;
  final Ref _ref;

  FirebaseStorageService(this._storage, this._ref);

  Future<String> uploadProfileImage(File file, User user) async {
    try {
      final filePath = 'affiliates/profile/${user.userName}/${user.id}';
      final fileRef = _storage.ref(filePath);

      final uploadTask = fileRef.putFile(file);
      final snapshot = await uploadTask.whenComplete(() => {});
      final downloadURL = await snapshot.ref.getDownloadURL();

      final affiliateService = _ref.read(affiliateServiceProvider);
      final updateRequest = UpdateImageRequest(
        imageProfileUrl: downloadURL,
      );

      await affiliateService.updateImage(user.id,updateRequest);

      return downloadURL;
    } on FirebaseException catch (e) {
      throw Exception('Error uploading to Firebase: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<void> removeProfileImage(User user) async {
    try {
      final filePath = 'affiliates/profile/${user.userName}/${user.id}';
      final fileRef = _storage.ref(filePath);

      await fileRef.delete();

      final affiliateService = _ref.read(affiliateServiceProvider);
      final updateRequest = UpdateImageRequest(
        imageProfileUrl: '',
      );

      await affiliateService.updateImage(user.id,updateRequest);
    } on FirebaseException catch (e) {
      if (e.code != 'object-not-found') {
        throw Exception('Error removing image from Firebase: ${e.message}');
      }
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}

final firebaseStorageServiceProvider = Provider<FirebaseStorageService>((ref) {
  return FirebaseStorageService(FirebaseStorage.instance, ref);
});

final affiliateServiceProvider = Provider((ref) {
  return AffiliateService();
});
