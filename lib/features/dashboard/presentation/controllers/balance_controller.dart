import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
