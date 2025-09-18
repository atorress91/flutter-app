import 'package:my_app/features/dashboard/domain/entities/client.dart';

class ClientsState {
  final bool isLoading;
  final String? error;
  final Client? uniLevelTree;

  const ClientsState({this.isLoading = false, this.error, this.uniLevelTree});

  ClientsState copyWith({
    bool? isLoading,
    String? error,
    Client? uniLevelTree,
  }) {
    return ClientsState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      uniLevelTree: uniLevelTree ?? this.uniLevelTree,
    );
  }
}
