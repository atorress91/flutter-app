import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/features/dashboard/domain/entities/balance_state.dart';

import 'package:my_app/features/dashboard/data/providers/balance_providers.dart';

class BalanceController extends StateNotifier<BalanceState> {
  final Ref _ref;

  BalanceController(this._ref) : super(const BalanceState());

  Future<void> getBalanceInformation() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final getBalanceUseCase = _ref.read(getBalanceInformationUseCaseProvider);
      final balance = await getBalanceUseCase.execute();
      state = state.copyWith(isLoading: false, balance: balance);
    } on ApiException catch (e) {
      final backendMessage = e.message;
      String errorMessage;

      if (backendMessage.toLowerCase().contains('user_not_found')) {
        errorMessage = 'No se pudo encontrar la información del usuario.';
      } else {
        errorMessage =
            'No se pudo cargar el balance. Inténtalo de nuevo más tarde.';
      }

      state = state.copyWith(isLoading: false, error: errorMessage);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Ocurrió un error inesperado al cargar tu balance.',
      );
    }
  }
}
