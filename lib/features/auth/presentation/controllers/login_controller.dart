import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/core/data/request/request_user_auth.dart';

import '../states/login_state.dart';
import '../../domain/use_cases/perform_login_use_case.dart';
import '../../data/providers/auth_providers.dart';
import '../providers/auth_state_provider.dart';

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
      final RequestUserAuth request =
          await _performLoginUseCase.execute(username, password);

      final session = await ref.read(authNotifierProvider.notifier).login(request);

      state = state.copyWith(isLoading: false);
      return session.user.isAffiliate;
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
