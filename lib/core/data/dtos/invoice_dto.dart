import 'package:json_annotation/json_annotation.dart';
import 'package:my_app/core/data/dtos/invoice_detail_dto.dart';

part 'invoice_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class InvoiceDto {
  @JsonKey(defaultValue: 0)
  final int id;

  @JsonKey(defaultValue: 0)
  final int invoiceNumber;

  @JsonKey(defaultValue: 0)
  final int purchaseOrderId;

  @JsonKey(defaultValue: 0)
  final int affiliateId;

  final double? totalInvoice;

  @JsonKey(defaultValue: 0.0)
  final double totalInvoiceBtc;

  final double? totalCommissionable;
  final int? totalPoints;

  @JsonKey(defaultValue: false)
  final bool state;

  @JsonKey(defaultValue: false)
  final bool status;

  final DateTime? date;
  final DateTime? cancellationDate;
  final String? paymentMethod;
  final String? bank;
  final String? receiptNumber;
  final DateTime? depositDate;
  final bool? type;
  final String? reason;
  final String? invoiceData;
  final String? invoiceAddress;
  final String? shippingAddress;
  final String? secretKey;
  final String? btcAddress;

  @JsonKey(defaultValue: 0)
  final int recurring;

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userName;
  final String? name;
  final String? lastName;

  @JsonKey(name: 'invoicesDetails', defaultValue: [])
  final List<InvoiceDetailDto> invoicesDetails;

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

  factory InvoiceDto.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceDtoToJson(this);
}
