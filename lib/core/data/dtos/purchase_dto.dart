class PurchaseDto {
  final int year;
  final int month;
  final int totalPurchases;

  PurchaseDto({
    required this.year,
    required this.month,
    required this.totalPurchases,
  });

  factory PurchaseDto.fromJson(Map<String, dynamic> json) {
    return PurchaseDto(
      year: json['year'] ?? 0,
      month: json['month'] ?? 0,
      totalPurchases: json['totalPurchases'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'year': year,
    'month': month,
    'totalPurchases': totalPurchases,
  };
}
