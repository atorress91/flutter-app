import 'package:my_app/features/dashboard/domain/entities/network_purchase.dart';
import 'package:my_app/features/dashboard/domain/repositories/network_purchase_repository.dart';

class GetNetworkPurchasesUseCase {
  final NetworkPurchaseRepository _networkPurchaseRepository;

  GetNetworkPurchasesUseCase(this._networkPurchaseRepository);

  Future<List<NetworkPurchase>> execute({required int userId}) async {
    return await _networkPurchaseRepository.getNetworkPurchases(userId);
  }
}
