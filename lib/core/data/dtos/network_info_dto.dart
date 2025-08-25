import 'package:my_app/core/data/dtos/purchase_dto.dart';

class NetworkInfoDto {
  final List<PurchaseDto> currentYearPurchases;
  final List<PurchaseDto> previousYearPurchases;

  NetworkInfoDto({
    required this.currentYearPurchases,
    required this.previousYearPurchases,
  });

  factory NetworkInfoDto.fromJson(Map<String, dynamic> json) {
    return NetworkInfoDto(
      currentYearPurchases:
          (json['currentYearPurchases'] as List<dynamic>?)
              ?.map((item) => PurchaseDto.fromJson(item))
              .toList() ??
          [],
      previousYearPurchases:
          (json['previousYearPurchases'] as List<dynamic>?)
              ?.map((item) => PurchaseDto.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'currentYearPurchases': currentYearPurchases
        .map((item) => item.toJson())
        .toList(),
    'previousYearPurchases': previousYearPurchases
        .map((item) => item.toJson())
        .toList(),
  };
}
