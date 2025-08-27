import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/core/data/request/request_user_registration.dart';

import '../states/registration_state.dart';
import '../../domain/use_cases/perform_registration_use_case.dart';
import '../../data/providers/auth_providers.dart';
import '../providers/auth_state_provider.dart';

class RegistrationController extends StateNotifier<RegistrationState> {
  RegistrationController(this.ref) : super(const RegistrationState());

  final Ref ref;

  PerformRegistrationUseCase get _performRegistrationUseCase =>
      ref.read(performRegistrationUseCaseProvider);

  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword);
  }

  void toggleTermsAcceptance() {
    state = state.copyWith(acceptedTerms: !state.acceptedTerms);
  }

  void selectCountry(String country) {
    state = state.copyWith(selectedCountry: country);
  }

  Future<bool> register({
    required String userName,
    required String password,
    required String confirmPassword,
    required String firstName,
    required String lastName,
    required String country,
    required String phoneNumber,
    required String email,
    required bool acceptedTerms,
    String? referralUserName,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Validaciones básicas
      if (password != confirmPassword) {
        state = state.copyWith(
          isLoading: false, 
          error: 'Las contraseñas no coinciden'
        );
        return false;
      }

      if (!acceptedTerms) {
        state = state.copyWith(
          isLoading: false,
          error: 'Debes aceptar los términos y condiciones'
        );
        return false;
      }

      final RequestUserRegistration request =
          await _performRegistrationUseCase.execute(
        userName: userName,
        password: password,
        confirmPassword: confirmPassword,
        firstName: firstName,
        lastName: lastName,
        country: country,
        phoneNumber: phoneNumber,
        email: email,
        acceptedTerms: acceptedTerms,
        referralUserName: referralUserName,
      );

      final _ = await ref.read(authNotifierProvider.notifier).register(request);

      state = state.copyWith(isLoading: false);
      return true;
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Ocurrió un error inesperado. Inténtalo de nuevo.',
      );
      return false;
    }
  }
}

final registrationControllerProvider =
    StateNotifierProvider<RegistrationController, RegistrationState>(
      (ref) => RegistrationController(ref),
    );