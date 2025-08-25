import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/errors/exceptions.dart';

import '../states/login_state.dart';
import '../../domain/use_cases/perform_login_use_case.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController(this.ref) : super(const LoginState());

  final Ref ref;

  PerformLoginUseCase get _performLoginUseCase =>
      ref.read(performLoginUseCaseProvider);

  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  Future<bool?> login(String username, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _performLoginUseCase.execute(username, password);
      state = state.copyWith(isLoading: false);
      return user.isAffiliate;
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      return null;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Ocurrió un error inesperado. Inténtalo de nuevo.',
      );
      return null;
    }
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>(
      (ref) => LoginController(ref),
    );
