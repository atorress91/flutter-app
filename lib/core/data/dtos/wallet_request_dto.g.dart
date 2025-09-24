// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletRequestDto _$WalletRequestDtoFromJson(Map<String, dynamic> json) =>
    WalletRequestDto(
      id: (json['id'] as num).toInt(),
      affiliateId: (json['affiliateId'] as num).toInt(),
      paymentAffiliateId: (json['paymentAffiliateId'] as num).toInt(),
      orderNumber: json['orderNumber'] as String?,
      adminUserName: json['adminUserName'] as String?,
      amount: (json['amount'] as num).toDouble(),
      concept: json['concept'] as String?,
      type: json['type'] as String?,
      invoiceNumber: (json['invoiceNumber'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$WalletRequestDtoToJson(WalletRequestDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'affiliateId': instance.affiliateId,
      'paymentAffiliateId': instance.paymentAffiliateId,
      'orderNumber': instance.orderNumber,
      'adminUserName': instance.adminUserName,
      'amount': instance.amount,
      'concept': instance.concept,
      'type': instance.type,
      'invoiceNumber': instance.invoiceNumber,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
