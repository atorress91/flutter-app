import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/core/services/platform/firebase_storage_service.dart';
import 'package:my_app/features/auth/presentation/providers/auth_state_provider.dart';

class ProfileImageUploader extends ConsumerWidget {
  const ProfileImageUploader({super.key});

  Future<void> _pickAndUploadImage(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final user = ref.read(authNotifierProvider).value?.user;
    if (user == null) {
      messenger.showSnackBar(
        const SnackBar(content: Text('You must be logged in.')),
      );
      return;
    }

    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      try {
        final storageService = ref.read(firebaseStorageServiceProvider);
        await storageService.uploadProfileImage(file, user);
        if (!context.mounted) return;

        await ref.read(authNotifierProvider.notifier).reloadFromStorage();
        if (!context.mounted) return;

        messenger.showSnackBar(
          const SnackBar(content: Text('Profile picture updated!')),
        );
      } catch (e) {
        if (!context.mounted) return;
        messenger.showSnackBar(
          SnackBar(content: Text('Upload failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authNotifierProvider).value?.user;

    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: user?.imageUrl != null
              ? NetworkImage(user!.imageUrl!)
              : null,
          child: user?.imageUrl == null
              ? const Icon(Icons.person, size: 50)
              : null,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _pickAndUploadImage(context, ref),
          child: const Text('Change Picture'),
        ),
      ],
    );
  }
}