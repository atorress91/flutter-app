import 'package:json_annotation/json_annotation.dart';

part 'wallet_request_dto.g.dart';

@JsonSerializable()
class WalletRequestDto {
  final int id;
  final int affiliateId;
  final int paymentAffiliateId;
  final String? orderNumber;
  final String? adminUserName;
  final double amount;
  final String? concept;
  final String? type;
  final int? invoiceNumber;
  final int? status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  WalletRequestDto({
    required this.id,
    required this.affiliateId,
    required this.paymentAffiliateId,
    this.orderNumber,
    this.adminUserName,
    required this.amount,
    this.concept,
    this.type,
    this.invoiceNumber,
    this.status,
    required this.createdAt,
    this.updatedAt,
  });

  factory WalletRequestDto.fromJson(Map<String, dynamic> json) =>
      _$WalletRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WalletRequestDtoToJson(this);
}
