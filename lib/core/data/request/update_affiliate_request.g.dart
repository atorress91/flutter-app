// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_affiliate_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAffiliateRequest _$UpdateAffiliateRequestFromJson(
  Map<String, dynamic> json,
) => UpdateAffiliateRequest(
  id: (json['id'] as num).toInt(),
  identification: json['identification'] as String?,
  name: json['name'] as String?,
  userName: json['user_name'] as String?,
  lastName: json['last_name'] as String?,
  address: json['address'] as String?,
  legalAuthorizedFirst: json['legal_authorized_first'] as String?,
  legalAuthorizedSecond: json['legal_authorized_second'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  zipCode: json['zip_code'] as String?,
  country: (json['country'] as num?)?.toInt(),
  statePlace: json['state_place'] as String?,
  city: json['city'] as String?,
  birthday: json['birthday'] == null
      ? null
      : DateTime.parse(json['birthday'] as String),
  taxId: json['tax_id'] as String?,
  beneficiaryName: json['beneficiary_name'] as String?,
  legalAuthorizeFirst: json['legal_authorize_first'] as String?,
  legalAuthorizeSecond: json['legal_authorize_second'] as String?,
  status: (json['status'] as num?)?.toInt(),
  affiliateType: json['affiliate_type'] as String?,
  father: (json['father'] as num?)?.toInt(),
  sponsor: (json['sponsor'] as num?)?.toInt(),
  termsConditions: json['termsConditions'] as bool,
  beneficiaryEmail: json['beneficiary_email'] as String?,
  beneficiaryPhone: json['beneficiary_phone'] as String?,
);

Map<String, dynamic> _$UpdateAffiliateRequestToJson(
  UpdateAffiliateRequest instance,
) => <String, dynamic>{
  'id': instance.id,
  'identification': instance.identification,
  'name': instance.name,
  'user_name': instance.userName,
  'last_name': instance.lastName,
  'address': instance.address,
  'legal_authorized_first': instance.legalAuthorizedFirst,
  'legal_authorized_second': instance.legalAuthorizedSecond,
  'phone': instance.phone,
  'email': instance.email,
  'zip_code': instance.zipCode,
  'country': instance.country,
  'state_place': instance.statePlace,
  'city': instance.city,
  'birthday': instance.birthday?.toIso8601String(),
  'tax_id': instance.taxId,
  'beneficiary_name': instance.beneficiaryName,
  'legal_authorize_first': instance.legalAuthorizeFirst,
  'legal_authorize_second': instance.legalAuthorizeSecond,
  'status': instance.status,
  'affiliate_type': instance.affiliateType,
  'father': instance.father,
  'sponsor': instance.sponsor,
  'termsConditions': instance.termsConditions,
  'beneficiary_email': instance.beneficiaryEmail,
  'beneficiary_phone': instance.beneficiaryPhone,
};
