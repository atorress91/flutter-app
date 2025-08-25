import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/core/services/api/wallet_service.dart';
import 'package:my_app/features/dashboard/data/mappers/network_purchase_mapper.dart';
import 'package:my_app/features/dashboard/domain/entities/network_purchase.dart';
import 'package:my_app/features/dashboard/domain/repositories/network_purchase_repository.dart';

class NetworkPurchaseRepositoryImpl implements NetworkPurchaseRepository {
  final WalletService _walletService;

  NetworkPurchaseRepositoryImpl(this._walletService);

  @override
  Future<List<NetworkPurchase>> getNetworkPurchases(int userId) async {
    final response = await _walletService.getPurchasesInMyNetwork(userId);

    if (response.success && response.data != null) {
      final currentYearPurchases = response.data!.currentYearPurchases
          .map((dto) => NetworkPurchaseMapper.fromDto(dto))
          .toList();
      final previousYearPurchases = response.data!.previousYearPurchases
          .map((dto) => NetworkPurchaseMapper.fromDto(dto))
          .toList();
      return [...currentYearPurchases, ...previousYearPurchases];
    } else {
      throw ApiException(
        response.message ?? 'Error al obtener las compras de la red',
      );
    }
  }
}
