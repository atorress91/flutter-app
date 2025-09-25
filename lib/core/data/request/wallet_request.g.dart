// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletRequest _$WalletRequestFromJson(Map<String, dynamic> json) =>
    WalletRequest(
      id: (json['id'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      affiliateId: (json['affiliateId'] as num).toInt(),
      affiliateName: json['affiliateName'] as String,
      userPassword: json['userPassword'] as String,
      verificationCode: json['verificationCode'] as String,
      amount: (json['amount'] as num).toDouble(),
      concept: json['concept'] as String,
      retention: (json['retention'] as num?)?.toInt(),
      isSelected: json['isSelected'] as bool?,
    );

Map<String, dynamic> _$WalletRequestToJson(WalletRequest instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'status': ?instance.status,
      'affiliateId': instance.affiliateId,
      'affiliateName': instance.affiliateName,
      'userPassword': instance.userPassword,
      'verificationCode': instance.verificationCode,
      'amount': instance.amount,
      'concept': instance.concept,
      'retention': ?instance.retention,
      'isSelected': ?instance.isSelected,
    };
