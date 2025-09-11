// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceDto _$InvoiceDtoFromJson(Map<String, dynamic> json) => InvoiceDto(
  id: (json['id'] as num?)?.toInt() ?? 0,
  invoiceNumber: (json['invoiceNumber'] as num?)?.toInt() ?? 0,
  purchaseOrderId: (json['purchaseOrderId'] as num?)?.toInt() ?? 0,
  affiliateId: (json['affiliateId'] as num?)?.toInt() ?? 0,
  totalInvoice: (json['totalInvoice'] as num?)?.toDouble(),
  totalInvoiceBtc: (json['totalInvoiceBtc'] as num?)?.toDouble() ?? 0.0,
  totalCommissionable: (json['totalCommissionable'] as num?)?.toDouble(),
  totalPoints: (json['totalPoints'] as num?)?.toInt(),
  state: json['state'] as bool? ?? false,
  status: json['status'] as bool? ?? false,
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  cancellationDate: json['cancellationDate'] == null
      ? null
      : DateTime.parse(json['cancellationDate'] as String),
  paymentMethod: json['paymentMethod'] as String?,
  bank: json['bank'] as String?,
  receiptNumber: json['receiptNumber'] as String?,
  depositDate: json['depositDate'] == null
      ? null
      : DateTime.parse(json['depositDate'] as String),
  type: json['type'] as bool?,
  reason: json['reason'] as String?,
  invoiceData: json['invoiceData'] as String?,
  invoiceAddress: json['invoiceAddress'] as String?,
  shippingAddress: json['shippingAddress'] as String?,
  secretKey: json['secretKey'] as String?,
  btcAddress: json['btcAddress'] as String?,
  recurring: (json['recurring'] as num?)?.toInt() ?? 0,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  userName: json['userName'] as String?,
  name: json['name'] as String?,
  lastName: json['lastName'] as String?,
  invoicesDetails:
      (json['invoicesDetails'] as List<dynamic>?)
          ?.map((e) => InvoiceDetailDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$InvoiceDtoToJson(
  InvoiceDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'invoiceNumber': instance.invoiceNumber,
  'purchaseOrderId': instance.purchaseOrderId,
  'affiliateId': instance.affiliateId,
  'totalInvoice': instance.totalInvoice,
  'totalInvoiceBtc': instance.totalInvoiceBtc,
  'totalCommissionable': instance.totalCommissionable,
  'totalPoints': instance.totalPoints,
  'state': instance.state,
  'status': instance.status,
  'date': instance.date?.toIso8601String(),
  'cancellationDate': instance.cancellationDate?.toIso8601String(),
  'paymentMethod': instance.paymentMethod,
  'bank': instance.bank,
  'receiptNumber': instance.receiptNumber,
  'depositDate': instance.depositDate?.toIso8601String(),
  'type': instance.type,
  'reason': instance.reason,
  'invoiceData': instance.invoiceData,
  'invoiceAddress': instance.invoiceAddress,
  'shippingAddress': instance.shippingAddress,
  'secretKey': instance.secretKey,
  'btcAddress': instance.btcAddress,
  'recurring': instance.recurring,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'userName': instance.userName,
  'name': instance.name,
  'lastName': instance.lastName,
  'invoicesDetails': instance.invoicesDetails.map((e) => e.toJson()).toList(),
};
