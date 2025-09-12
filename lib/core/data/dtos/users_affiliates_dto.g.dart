// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_affiliates_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersAffiliatesDto _$UsersAffiliatesDtoFromJson(Map<String, dynamic> json) =>
    UsersAffiliatesDto(
      id: (json['id'] as num).toInt(),
      userName: json['user_name'] as String? ?? '',
      identification: json['identification'] as String? ?? '',
      email: json['email'] as String? ?? '',
      isAffiliate: (json['is_affiliate'] as num?)?.toInt() ?? 0,
      status: const _IntBoolConverter().fromJson(
        (json['status'] as num).toInt(),
      ),
      name: json['name'] as String?,
      lastName: json['last_name'] as String?,
      imageProfileUrl: json['image_profile_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      birthDay: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      beneficiaryName: json['beneficiary_name'] as String?,
      beneficiaryEmail: json['beneficiary_email'] as String?,
      beneficiaryPhone: json['beneficiary_phone'] as String?,
    );

Map<String, dynamic> _$UsersAffiliatesDtoToJson(UsersAffiliatesDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_name': instance.userName,
      'identification': instance.identification,
      'email': instance.email,
      'is_affiliate': instance.isAffiliate,
      'status': const _IntBoolConverter().toJson(instance.status),
      'name': instance.name,
      'last_name': instance.lastName,
      'image_profile_url': instance.imageProfileUrl,
      'created_at': instance.createdAt.toIso8601String(),
      'birthday': instance.birthDay?.toIso8601String(),
      'address': instance.address,
      'phone': instance.phone,
      'beneficiary_name': instance.beneficiaryName,
      'beneficiary_email': instance.beneficiaryEmail,
      'beneficiary_phone': instance.beneficiaryPhone,
    };
