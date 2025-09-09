import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:my_app/features/dashboard/data/providers/account_providers.dart';

final profileScreenControllerProvider = Provider.autoDispose((ref) {
  return ProfileScreenController(ref);
});

class ProfileScreenController {
  final Ref _ref;

  ProfileScreenController(this._ref);

  Future<bool> updateProfilePicture() async {
    final user = _ref.read(authNotifierProvider).value?.user;
    if (user == null) {
      throw Exception('Debes iniciar sesión.');
    }

    final updateProfilePicture = _ref.read(updateProfilePictureUseCaseProvider);

    final updatedUser = await updateProfilePicture.execute(user);

    if (updatedUser != null) {
      await _ref.read(authNotifierProvider.notifier).updateSession(updatedUser);
      return true;
    }
    return false;
  }
}
