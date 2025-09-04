import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:my_app/features/dashboard/data/providers/balance_providers.dart';
import 'package:my_app/features/dashboard/data/providers/wallet_providers.dart';
import 'package:my_app/features/dashboard/domain/entities/balance_information.dart';
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

      final getBalanceUseCase = _ref.read(getBalanceInformationUseCaseProvider);
      final getTransactionsUseCase = _ref.read(getWalletTransactionsUseCaseProvider);
      final transactions = await getTransactionsUseCase.execute(userId: userId);

      BalanceInformation? balance;
      try {
        balance = await getBalanceUseCase.execute(userId: userId);
      }catch(e){
        // do nothing
      }

      state = state.copyWith(isLoading: false, transactions: transactions,balance: balance);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Ocurrió un error al cargar las transacciones.');
    }
  }

  void setFilter(TransactionFilterType filter) {
    state = state.copyWith(filter: filter);
  }

  Future<void> refresh() async {
    await loadTransactions();
  }
}

final myWalletControllerProvider = StateNotifierProvider<MyWalletScreenController, MyWalletState>(
      (ref) => MyWalletScreenController(ref),
);