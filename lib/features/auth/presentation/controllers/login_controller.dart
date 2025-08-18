import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/models/api_response.dart';
import '../../domain/entities/login_state.dart';
import '../../domain/services/login_service.dart';

class LoginController extends StateNotifier<LoginState> {
  final LoginService _loginService;

  LoginController(this._loginService) : super(const LoginState());

  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  Future<ApiResponse<bool>> login(String username, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _loginService.performLogin(username, password);

    if (result.success) {
      state = state.copyWith(isLoading: false);
    } else {
      state = state.copyWith(isLoading: false, error: result.message);
    }

    return result;
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Actualiza el provider para inyectar la dependencia
final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
      final loginService = ref.watch(loginServiceProvider);
      return LoginController(loginService);
    });
