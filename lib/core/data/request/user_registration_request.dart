import 'package:json_annotation/json_annotation.dart';

part 'user_registration_request.g.dart';

@JsonSerializable(includeIfNull: false)
class UserRegistrationRequest {
  final String userName;
  final String password;
  final String confirmPassword;
  final String firstName;
  final String lastName;
  final String country;
  final String phoneNumber;
  final String email;
  final bool acceptedTerms;
  final String? referralUserName;
  final String? browserInfo;
  final String? ipAddress;
  final String? operatingSystem;

  UserRegistrationRequest({
    required this.userName,
    required this.password,
    required this.confirmPassword,
    required this.firstName,
    required this.lastName,
    required this.country,
    required this.phoneNumber,
    required this.email,
    required this.acceptedTerms,
    this.referralUserName,
    this.browserInfo,
    this.ipAddress,
    this.operatingSystem,
  });

  factory UserRegistrationRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRegistrationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegistrationRequestToJson(this);
}
