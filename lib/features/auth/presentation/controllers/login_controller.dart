import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/login_state.dart';
import '../../domain/use_cases/perform_login_use_case.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController(this.ref) : super(const LoginState());

  final Ref ref;

  PerformLoginUseCase get _performLoginUseCase =>
      ref.read(performLoginUseCaseProvider);

  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  /// Delega el proceso de login al Caso de Uso.
  Future<bool?> login(String username, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _performLoginUseCase.execute(username, password);
      state = state.copyWith(isLoading: false);

      return user.isAffiliate;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return null;
    }
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>(
      (ref) => LoginController(ref),
    );
