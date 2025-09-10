// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletDto _$WalletDtoFromJson(Map<String, dynamic> json) => WalletDto(
  id: (json['id'] as num).toInt(),
  affiliateId: (json['affiliateId'] as num).toInt(),
  affiliateUserName: json['affiliateUserName'] as String?,
  adminUserName: json['adminUserName'] as String?,
  userId: (json['userId'] as num).toInt(),
  credit: (json['credit'] as num).toDouble(),
  debit: (json['debit'] as num).toDouble(),
  deferred: (json['deferred'] as num?)?.toDouble(),
  status: json['status'] as bool? ?? false,
  concept: json['concept'] as String?,
  support: (json['support'] as num?)?.toInt(),
  date: DateTime.parse(json['date'] as String),
  compression: const _IntBoolConverter().fromJson(
    (json['compression'] as num).toInt(),
  ),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$WalletDtoToJson(WalletDto instance) => <String, dynamic>{
  'id': instance.id,
  'affiliateId': instance.affiliateId,
  'affiliateUserName': instance.affiliateUserName,
  'adminUserName': instance.adminUserName,
  'userId': instance.userId,
  'credit': instance.credit,
  'debit': instance.debit,
  'deferred': instance.deferred,
  'status': instance.status,
  'concept': instance.concept,
  'support': instance.support,
  'date': instance.date.toIso8601String(),
  'compression': const _IntBoolConverter().toJson(instance.compression),
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};
