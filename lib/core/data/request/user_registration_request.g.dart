// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_registration_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegistrationRequest _$UserRegistrationRequestFromJson(
  Map<String, dynamic> json,
) => UserRegistrationRequest(
  userName: json['userName'] as String,
  password: json['password'] as String,
  confirmPassword: json['confirmPassword'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  country: json['country'] as String,
  phoneNumber: json['phoneNumber'] as String,
  email: json['email'] as String,
  acceptedTerms: json['acceptedTerms'] as bool,
  referralUserName: json['referralUserName'] as String?,
  browserInfo: json['browserInfo'] as String?,
  ipAddress: json['ipAddress'] as String?,
  operatingSystem: json['operatingSystem'] as String?,
);

Map<String, dynamic> _$UserRegistrationRequestToJson(
  UserRegistrationRequest instance,
) => <String, dynamic>{
  'userName': instance.userName,
  'password': instance.password,
  'confirmPassword': instance.confirmPassword,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'country': instance.country,
  'phoneNumber': instance.phoneNumber,
  'email': instance.email,
  'acceptedTerms': instance.acceptedTerms,
  'referralUserName': ?instance.referralUserName,
  'browserInfo': ?instance.browserInfo,
  'ipAddress': ?instance.ipAddress,
  'operatingSystem': ?instance.operatingSystem,
};
