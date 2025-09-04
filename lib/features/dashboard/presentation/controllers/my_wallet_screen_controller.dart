import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:my_app/features/dashboard/data/providers/wallet_providers.dart';
import 'package:my_app/features/dashboard/presentation/states/my_wallet_state.dart';

class MyWalletScreenController extends StateNotifier<MyWalletState> {
  final Ref _ref;

  MyWalletScreenController(this._ref) : super(const MyWalletState());

  Future<void> loadTransactions() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final userId = _ref.read(authNotifierProvider).value?.user.id;
      if (userId == null) {
        throw Exception('Usuario no autenticado');
      }

      final getTransactionsUseCase = _ref.read(getWalletTransactionsUseCaseProvider);
      final transactions = await getTransactionsUseCase.execute(userId: userId);

      state = state.copyWith(isLoading: false, transactions: transactions);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Ocurrió un error al cargar las transacciones.');
    }
  }

  Future<void> refresh() async {
    await loadTransactions();
  }
}

final myWalletControllerProvider = StateNotifierProvider<MyWalletScreenController, MyWalletState>(
      (ref) => MyWalletScreenController(ref),
);