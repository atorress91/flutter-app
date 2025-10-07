import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  ForgotPasswordController() : super(ForgotPasswordState());

  /// Envía un código de recuperación al email del usuario
  Future<bool> sendPasswordResetCode(String email) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // TODO: Implementar la lógica real para enviar el código
      // Por ejemplo, llamar a un servicio de backend o Firebase

      // Simulación de petición HTTP
      await Future.delayed(const Duration(seconds: 2));

      // Aquí deberías hacer algo como:
      // final response = await _authRepository.sendPasswordResetCode(email);
      // if (response.success) {
      //   state = state.copyWith(isLoading: false, success: true);
      //   return true;
      // } else {
      //   state = state.copyWith(
      //     isLoading: false,
      //     success: false,
      //     errorMessage: response.errorMessage,
      //   );
      //   return false;
      // }

      // Por ahora, simular éxito
      state = state.copyWith(isLoading: false, success: true);
      return true;

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
  (ref) => ForgotPasswordController(),
);

