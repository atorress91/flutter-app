import 'dart:io';
import 'package:my_app/features/auth/domain/entities/user.dart';

abstract class ProfileRepository {
  Future<String> uploadProfileImage(File imageFile, User user);
  Future<User> updateProfileImage(User user);
  Future<User> updateUserProfile(User user);
}