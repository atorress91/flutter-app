import 'package:my_app/core/data/dtos/purchase_dto.dart';
import 'package:my_app/features/dashboard/domain/entities/network_purchase.dart';

class NetworkPurchaseMapper {
  static NetworkPurchase fromDto(PurchaseDto dto) {
    return NetworkPurchase(
      year: dto.year,
      month: dto.month,
      totalPurchases: dto.totalPurchases,
    );
  }
}