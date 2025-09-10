// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_auth_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAuthRequest _$UserAuthRequestFromJson(Map<String, dynamic> json) =>
    UserAuthRequest(
      userName: json['userName'] as String,
      password: json['password'] as String,
      browserInfo: json['browserInfo'] as String?,
      ipAddress: json['ipAddress'] as String?,
      operatingSystem: json['operatingSystem'] as String?,
    );

Map<String, dynamic> _$UserAuthRequestToJson(UserAuthRequest instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'password': instance.password,
      'browserInfo': ?instance.browserInfo,
      'ipAddress': ?instance.ipAddress,
      'operatingSystem': ?instance.operatingSystem,
    };
