import 'package:my_app/features/dashboard/domain/entities/network_purchase.dart';

abstract class NetworkPurchaseRepository {
  Future<List<NetworkPurchase>> getNetworkPurchases(int userId);
}
