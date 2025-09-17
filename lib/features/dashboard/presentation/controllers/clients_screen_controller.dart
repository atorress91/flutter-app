import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:my_app/features/dashboard/data/providers/account_providers.dart';

import 'package:my_app/features/dashboard/presentation/states/clients_state.dart';

class ClientsScreenController extends StateNotifier<ClientsState> {
  final Ref _ref;

  ClientsScreenController(this._ref) : super(const ClientsState());

  Future<void> loadUnilevelTree() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final userId = _ref.read(authNotifierProvider).value?.user.id;
      if (userId == null) {
        throw Exception('Usuario no autenticado');
      }

      final getUnilevelTree = _ref.read(getUniLevelTreeUseCaseProvider);
      final unilevelTree = await getUnilevelTree.execute(userId: userId);
      state = state.copyWith(isLoading: false, unilevelTree: unilevelTree);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Ocurrió un error al cargar el árbol de clientes.',
      );
    }
  }

  Future<void> refresh() async {
    await loadUnilevelTree();
  }
}

final clientsScreenControllerProvider =
    StateNotifierProvider<ClientsScreenController, ClientsState>(
      (ref) => ClientsScreenController(ref),
    );
