import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:my_app/features/dashboard/domain/entities/balance_state.dart';

import 'package:my_app/features/dashboard/data/providers/balance_providers.dart';

class BalanceController extends StateNotifier<BalanceState> {
  final Ref _ref;

  BalanceController(this._ref) : super(const BalanceState());

  Future<void> getBalanceInformation() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final userId = _ref.read(authNotifierProvider).value?.user.id;
      if (userId == null) {
        throw AuthException('Usuario no autenticado');
      }

      final getBalanceUseCase = _ref.read(getBalanceInformationUseCaseProvider);
      final balance = await getBalanceUseCase.execute(userId: userId);
      state = state.copyWith(isLoading: false, balance: balance);
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Ocurrió un error inesperado al cargar tu balance.',
      );
    }
  }
}
