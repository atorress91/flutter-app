import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:my_app/features/dashboard/presentation/states/edit_profile_form_state.dart';

final editProfileFormProvider =
    StateNotifierProvider<EditProfileFormNotifier, EditProfileFormState>((ref) {
      return EditProfileFormNotifier(ref);
    });

class EditProfileFormNotifier extends StateNotifier<EditProfileFormState> {
  final Ref ref;

  EditProfileFormNotifier(this.ref) : super(const EditProfileFormState()) {
    _initializeFromUser();
  }

  void _initializeFromUser() {
    final user = ref.read(authNotifierProvider).value?.user;
    if (user != null) {
      state = EditProfileFormState(
        name: user.name ?? '',
        lastName: user.lastName ?? '',
        phone: user.phone ?? '',
        address: user.address ?? '',
        beneficiaryName: user.beneficiaryName ?? '',
        beneficiaryEmail: user.beneficiaryEmail ?? '',
        beneficiaryPhone: user.beneficiaryPhone ?? '',
      );
    }
  }

  void update({
    String? name,
    String? lastName,
    String? phone,
    String? address,
    String? beneficiaryName,
    String? beneficiaryEmail,
    String? beneficiaryPhone,
  }) {
    state = state.copyWith(
      name: name,
      lastName: lastName,
      phone: phone,
      address: address,
      beneficiaryName: beneficiaryName,
      beneficiaryEmail: beneficiaryEmail,
      beneficiaryPhone: beneficiaryPhone,
    );
  }

  void reset() {
    _initializeFromUser();
  }
}
