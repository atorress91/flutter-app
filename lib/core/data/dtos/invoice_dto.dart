import 'package:my_app/core/data/dtos/invoice_detail_dto.dart';

class InvoiceDto {
  int id;
  int invoiceNumber;
  int purchaseOrderId;
  int affiliateId;
  double? totalInvoice;
  double totalInvoiceBtc;
  double? totalCommissionable;
  int? totalPoints;
  bool state;
  bool status;
  DateTime? date;
  DateTime? cancellationDate;
  String? paymentMethod;
  String? bank;
  String? receiptNumber;
  DateTime? depositDate;
  bool? type;
  String? reason;
  String? invoiceData;
  String? invoiceAddress;
  String? shippingAddress;
  String? secretKey;
  String? btcAddress;
  int recurring;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userName;
  String? name;

  String? lastName;
  List<InvoiceDetailDto> invoicesDetails;

  InvoiceDto({
    required this.id,
    required this.invoiceNumber,
    required this.purchaseOrderId,
    required this.affiliateId,
    this.totalInvoice,
    required this.totalInvoiceBtc,
    this.totalCommissionable,
    this.totalPoints,
    required this.state,
    required this.status,
    this.date,
    this.cancellationDate,
    this.paymentMethod,
    this.bank,
    this.receiptNumber,
    this.depositDate,
    this.type,
    this.reason,
    this.invoiceData,
    this.invoiceAddress,
    this.shippingAddress,
    this.secretKey,
    this.btcAddress,
    required this.recurring,
    this.createdAt,
    this.updatedAt,
    this.userName,
    this.name,
    this.lastName,
    required this.invoicesDetails,
  });

  factory InvoiceDto.fromJson(Map<String, dynamic> json) {
    return InvoiceDto(
      id: json['id'] ?? 0,
      invoiceNumber: json['invoiceNumber'] ?? 0,
      purchaseOrderId: json['purchaseOrderId'] ?? 0,
      affiliateId: json['affiliateId'] ?? 0,
      totalInvoice: (json['totalInvoice'] != null) ? (json['totalInvoice'] as num).toDouble() : null,
      totalInvoiceBtc: (json['totalInvoiceBtc'] != null) ? (json['totalInvoiceBtc'] as num).toDouble() : 0.0,
      totalCommissionable: (json['totalCommissionable'] != null) ? (json['totalCommissionable'] as num).toDouble() : null,
      totalPoints: json['totalPoints'],
      state: json['state'] ?? false,
      status: json['status'] ?? false,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      cancellationDate: json['cancellationDate'] != null ? DateTime.parse(json['cancellationDate']) : null,
      paymentMethod: json['paymentMethod'],
      bank: json['bank'],
      receiptNumber: json['receiptNumber'],
      depositDate:
      json['depositDate'] != null ? DateTime.parse(json['depositDate']) : null,
      type: json['type'],
      reason: json['reason'],
      invoiceData: json['invoiceData'],
      invoiceAddress: json['invoiceAddress'],
      shippingAddress: json['shippingAddress'],
      secretKey: json['secretKey'],
      btcAddress: json['btcAddress'],
      recurring: json['recurring'] ?? 0,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      userName: json['userName'],
      name: json['name'],
      lastName: json['lastName'],
      invoicesDetails: (json['invoicesDetails'] is List) ? (json['invoicesDetails'] as List)
          .map((e) => InvoiceDetailDto.fromJson(e as Map<String, dynamic>))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoiceNumber': invoiceNumber,
      'purchaseOrderId': purchaseOrderId,
      'affiliateId': affiliateId,
      'totalInvoice': totalInvoice,
      'totalInvoiceBtc': totalInvoiceBtc,
      'totalCommissionable': totalCommissionable,
      'totalPoints': totalPoints,
      'state': state,
      'status': status,
      'date': date?.toIso8601String(),
      'cancellationDate': cancellationDate?.toIso8601String(),
      'paymentMethod': paymentMethod,
      'bank': bank,
      'receiptNumber': receiptNumber,
      'depositDate': depositDate?.toIso8601String(),
      'type': type,
      'reason': reason,
      'invoiceData': invoiceData,
      'invoiceAddress': invoiceAddress,
      'shippingAddress': shippingAddress,
      'secretKey': secretKey,
      'btcAddress': btcAddress,
      'recurring': recurring,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'userName': userName,
      'name': name,
      'lastName': lastName,
      'details': invoicesDetails.map((e) => e.toJson()).toList(),
    };
  }
}
