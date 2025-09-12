// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserProfileRequest _$UpdateUserProfileRequestFromJson(
  Map<String, dynamic> json,
) => UpdateUserProfileRequest(
  identification: json['identification'] as String,
  binaryMatrixSide: (json['binary_matrix_side'] as num).toInt(),
  phone: json['phone'] as String,
  address: json['address'] as String?,
  zipCode: json['zip_code'] as String?,
  country: (json['country'] as num?)?.toInt(),
  birthday: json['birthday'] == null
      ? null
      : DateTime.parse(json['birthday'] as String),
  taxId: json['tax_id'] as String?,
  legalAuthorizedFirst: json['legal_authorized_first'] as String?,
  legalAuthorizedSecond: json['legal_authorized_second'] as String?,
  beneficiaryName: json['beneficiary_name'] as String?,
  beneficiaryEmail: json['beneficiary_email'] as String?,
  beneficiaryPhone: json['beneficiary_phone'] as String?,
);

Map<String, dynamic> _$UpdateUserProfileRequestToJson(
  UpdateUserProfileRequest instance,
) => <String, dynamic>{
  'identification': instance.identification,
  'binary_matrix_side': instance.binaryMatrixSide,
  'address': instance.address,
  'phone': instance.phone,
  'zip_code': instance.zipCode,
  'country': instance.country,
  'birthday': instance.birthday?.toIso8601String(),
  'tax_id': instance.taxId,
  'legal_authorized_first': instance.legalAuthorizedFirst,
  'legal_authorized_second': instance.legalAuthorizedSecond,
  'beneficiary_name': instance.beneficiaryName,
  'beneficiary_email': instance.beneficiaryEmail,
  'beneficiary_phone': instance.beneficiaryPhone,
};
