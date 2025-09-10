import 'package:json_annotation/json_annotation.dart';

part 'user_auth_request.g.dart';

@JsonSerializable(includeIfNull: false)
class UserAuthRequest {
  final String userName;
  final String password;
  final String? browserInfo;
  final String? ipAddress;
  final String? operatingSystem;

  UserAuthRequest({
    required this.userName,
    required this.password,
    this.browserInfo,
    this.ipAddress,
    this.operatingSystem,
  });

  factory UserAuthRequest.fromJson(Map<String, dynamic> json) =>
      _$UserAuthRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserAuthRequestToJson(this);
}
