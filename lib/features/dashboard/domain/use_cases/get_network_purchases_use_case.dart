import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:my_app/features/dashboard/domain/entities/network_purchase.dart';
import 'package:my_app/features/dashboard/data/providers/network_purchase_providers.dart';

class GetNetworkPurchasesUseCase {
  final Ref _ref;

  GetNetworkPurchasesUseCase(this._ref);

  Future<List<NetworkPurchase>> execute() async {
    final authState = _ref.read(authNotifierProvider);
    final userId = authState.value?.user.id;

    if (userId == null) {
      throw Exception("User not authenticated");
    }

    final networkPurchaseRepository = _ref.read(
      networkPurchaseRepositoryProvider,
    );
    return await networkPurchaseRepository.getNetworkPurchases(userId);
  }
}
