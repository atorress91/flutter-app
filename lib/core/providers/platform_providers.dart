import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:my_app/core/services/platform/biometric_service.dart';
import 'package:my_app/core/services/platform/firebase_storage_service.dart';
import 'package:my_app/core/services/platform/image_picker_service.dart';

// =============================================================================
// PLATFORM SERVICES
// =============================================================================

final secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(),
);

final firebaseStorageProvider = Provider<FirebaseStorage>(
  (ref) => FirebaseStorage.instance,
);

final firebaseStorageServiceProvider = Provider<FirebaseStorageService>(
  (ref) => FirebaseStorageService(
    ref.watch(firebaseStorageProvider),
    ref,
  ),
);

final imagePickerProvider = Provider<ImagePicker>(
  (ref) => ImagePicker(),
);

final imagePickerServiceProvider = Provider<ImagePickerService>(
  (ref) => ImagePickerServiceImpl(ref.watch(imagePickerProvider)),
);

final localAuthProvider = Provider<LocalAuthentication>(
  (ref) => LocalAuthentication(),
);

final biometricServiceProvider = Provider<BiometricService>(
  (ref) => BiometricService(
    ref.watch(localAuthProvider),
    ref.watch(secureStorageProvider),
  ),
);
