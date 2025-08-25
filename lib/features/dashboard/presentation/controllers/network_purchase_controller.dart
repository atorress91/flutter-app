import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/features/dashboard/data/providers/network_purchase_providers.dart';
import 'package:my_app/features/dashboard/domain/entities/network_purchase_state.dart';

class NetworkPurchaseController extends StateNotifier<NetworkPurchaseState> {
  final Ref _ref;

  NetworkPurchaseController(this._ref) : super(const NetworkPurchaseState());

  Future<void> getNetworkPurchases() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final getNetworkPurchasesUseCase = _ref.read(
        getNetworkPurchasesUseCaseProvider,
      );
      final purchases = await getNetworkPurchasesUseCase.execute();
      state = state.copyWith(isLoading: false, purchases: purchases);
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Ocurrió un error inesperado al cargar las compras de la red.',
      );
    }
  }
}
