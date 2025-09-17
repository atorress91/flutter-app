import 'package:my_app/features/dashboard/domain/entities/unilevel_tree.dart';

class ClientsState {
  final bool isLoading;
  final String? error;
  final UniLevelTree? unilevelTree;

  const ClientsState({this.isLoading = false, this.error, this.unilevelTree});

  ClientsState copyWith({
    bool? isLoading,
    String? error,
    UniLevelTree? unilevelTree,
  }) {
    return ClientsState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      unilevelTree: unilevelTree ?? this.unilevelTree,
    );
  }
}
