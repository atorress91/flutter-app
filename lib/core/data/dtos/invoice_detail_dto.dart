class InvoiceDetailDto {
  int id;
  int invoiceId;
  int productId;
  int paymentGroupId;
  bool accumMinPurchase;
  String? productName;
  double productPrice;
  double productPriceBtc;
  double? productIva;
  int productQuantity;
  double? productCommissionable;
  double binaryPoints;
  int? productPoints;
  double productDiscount;
  DateTime date;
  int combinationId;
  bool productPack;
  double? baseAmount;
  double? dailyPercentage;
  int? waitingDays;
  int daysToPayQuantity;
  bool productStart;
  DateTime createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  InvoiceDetailDto({
    required this.id,
    required this.invoiceId,
    required this.productId,
    required this.paymentGroupId,
    required this.accumMinPurchase,
    this.productName,
    required this.productPrice,
    required this.productPriceBtc,
    this.productIva,
    required this.productQuantity,
    this.productCommissionable,
    required this.binaryPoints,
    this.productPoints,
    required this.productDiscount,
    required this.date,
    required this.combinationId,
    required this.productPack,
    this.baseAmount,
    this.dailyPercentage,
    this.waitingDays,
    required this.daysToPayQuantity,
    required this.productStart,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory InvoiceDetailDto.fromJson(Map<String, dynamic> json) {
    return InvoiceDetailDto(
      id: json['id'] ?? 0,
      invoiceId: json['invoiceId'] ?? 0,
      productId: json['productId'] ?? 0,
      paymentGroupId: json['paymentGroupId'] ?? 0,
      accumMinPurchase: json['accumMinPurchase'] ?? false,
      productName: json['productName'],
      productPrice: (json['productPrice'] ?? 0).toDouble(),
      productPriceBtc: (json['productPriceBtc'] ?? 0).toDouble(),
      productIva: json['productIva']?.toDouble(),
      productQuantity: json['productQuantity'] ?? 0,
      productCommissionable: json['productCommissionable']?.toDouble(),
      binaryPoints: (json['binaryPoints'] ?? 0).toDouble(),
      productPoints: json['productPoints'],
      productDiscount: (json['productDiscount'] ?? 0).toDouble(),
      date: DateTime.parse(json['date']),
      combinationId: json['combinationId'] ?? 0,
      productPack: json['productPack'] ?? false,
      baseAmount: json['baseAmount']?.toDouble(),
      dailyPercentage: json['dailyPercentage']?.toDouble(),
      waitingDays: json['waitingDays'],
      daysToPayQuantity: json['daysToPayQuantity'] ?? 0,
      productStart: json['productStart'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoiceId': invoiceId,
      'productId': productId,
      'paymentGroupId': paymentGroupId,
      'accumMinPurchase': accumMinPurchase,
      'productName': productName,
      'productPrice': productPrice,
      'productPriceBtc': productPriceBtc,
      'productIva': productIva,
      'productQuantity': productQuantity,
      'productCommissionable': productCommissionable,
      'binaryPoints': binaryPoints,
      'productPoints': productPoints,
      'productDiscount': productDiscount,
      'date': date.toIso8601String(),
      'combinationId': combinationId,
      'productPack': productPack,
      'baseAmount': baseAmount,
      'dailyPercentage': dailyPercentage,
      'waitingDays': waitingDays,
      'daysToPayQuantity': daysToPayQuantity,
      'productStart': productStart,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }
}