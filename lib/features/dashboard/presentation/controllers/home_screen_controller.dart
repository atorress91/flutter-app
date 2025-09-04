import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:my_app/features/dashboard/data/providers/balance_providers.dart';
import 'package:my_app/features/dashboard/data/providers/network_purchase_providers.dart';
import 'package:my_app/features/dashboard/domain/entities/balance_information.dart'
    show BalanceInformation;
import 'package:my_app/features/dashboard/domain/entities/network_purchase.dart';
import 'package:my_app/features/dashboard/presentation/states/home_state.dart';

class HomeScreenController extends StateNotifier<HomeState> {
  final Ref _ref;

  HomeScreenController(this._ref) : super(const HomeState());

  Future<void> loadInitialData() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final userId = _ref.read(authNotifierProvider).value?.user.id;
      if (userId == null) {
        throw Exception('Usuario no autenticado');
      }

      final getBalanceUseCase = _ref.read(getBalanceInformationUseCaseProvider);
      final getPurchasesUseCase = _ref.read(getNetworkPurchasesUseCaseProvider);

      final results = await Future.wait([
        getBalanceUseCase.execute(userId: userId),
        getPurchasesUseCase.execute(userId: userId),
      ]);

      final [
        balance as BalanceInformation,
        purchases as List<NetworkPurchase>,
      ] = results;

      state = state.copyWith(
        isLoading: false,
        balance: balance,
        purchases: purchases,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Ocurrió un error inesperado al cargar los datos.',
      );
    }
  }

  Future<void> refresh() async {
    await loadInitialData();
  }
}

final homeScreenControllerProvider =
    StateNotifierProvider<HomeScreenController, HomeState>(
      (ref) => HomeScreenController(ref),
    );
