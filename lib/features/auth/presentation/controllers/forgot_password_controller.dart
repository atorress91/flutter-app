import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/features/auth/data/providers/auth_providers.dart';
import 'package:my_app/features/auth/domain/use_cases/send_password_reset_link_use_case.dart';

// Estado para el controlador de recuperación de contraseña
class ForgotPasswordState {
  final bool isLoading;
  final String? errorMessage;
  final bool? success;

  ForgotPasswordState({
    this.isLoading = false,
    this.errorMessage,
    this.success,
  });

  ForgotPasswordState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? success,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      success: success ?? this.success,
    );
  }
}

// Controlador para la recuperación de contraseña
class ForgotPasswordController extends StateNotifier<ForgotPasswordState> {
  final SendPasswordResetLinkUseCase _sendPasswordResetLinkUseCase;

  ForgotPasswordController(this._sendPasswordResetLinkUseCase)
      : super(ForgotPasswordState());

  /// Envía un link de recuperación al email del usuario
  Future<bool> sendPasswordResetCode(String email) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final success = await _sendPasswordResetLinkUseCase.execute(email);

      state = state.copyWith(isLoading: false, success: success);
      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        success: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  /// Reinicia el estado
  void reset() {
    state = ForgotPasswordState();
  }
}

// Provider del controlador
final forgotPasswordControllerProvider =
    StateNotifierProvider<ForgotPasswordController, ForgotPasswordState>(
  (ref) => ForgotPasswordController(
    ref.watch(sendPasswordResetLinkUseCaseProvider),
  ),
);
