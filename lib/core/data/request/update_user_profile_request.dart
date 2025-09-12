import 'package:json_annotation/json_annotation.dart';

part 'update_user_profile_request.g.dart';

@JsonSerializable()
class UpdateUserProfileRequest {
  final String identification;

  @JsonKey(name: 'binary_matrix_side')
  final int binaryMatrixSide;

  final String? address;
  final String phone;

  @JsonKey(name: 'zip_code')
  final String? zipCode;

  final int? country;
  final DateTime? birthday;

  @JsonKey(name: 'tax_id')
  final String? taxId;

  @JsonKey(name: 'legal_authorized_first')
  final String? legalAuthorizedFirst;

  @JsonKey(name: 'legal_authorized_second')
  final String? legalAuthorizedSecond;

  @JsonKey(name: 'beneficiary_name')
  final String? beneficiaryName;

  @JsonKey(name: 'beneficiary_email')
  final String? beneficiaryEmail;

  @JsonKey(name: 'beneficiary_phone')
  final String? beneficiaryPhone;

  UpdateUserProfileRequest({
    required this.identification,
    required this.binaryMatrixSide,
    required this.phone,
    this.address,
    this.zipCode,
    this.country,
    this.birthday,
    this.taxId,
    this.legalAuthorizedFirst,
    this.legalAuthorizedSecond,
    this.beneficiaryName,
    this.beneficiaryEmail,
    this.beneficiaryPhone,
  });

  factory UpdateUserProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserProfileRequestToJson(this);
}
