import 'package:json_annotation/json_annotation.dart';
part 'update_affiliate_request.g.dart';

@JsonSerializable()
class UpdateAffiliateRequest {
  final int id;
  final String? identification;
  final String? name;

  @JsonKey(name: 'user_name')
  final String? userName;

  @JsonKey(name: 'last_name')
  final String? lastName;

  final String? address;

  @JsonKey(name: 'legal_authorized_first')
  final String? legalAuthorizedFirst;

  @JsonKey(name: 'legal_authorized_second')
  final String? legalAuthorizedSecond;

  final String? phone;
  final String? email;

  @JsonKey(name: 'zip_code')
  final String? zipCode;

  final int? country;

  @JsonKey(name: 'state_place')
  final String? statePlace;

  final String? city;
  final DateTime? birthday;

  @JsonKey(name: 'tax_id')
  final String? taxId;

  @JsonKey(name: 'beneficiary_name')
  final String? beneficiaryName;

  // Nota: Habían dos propiedades con nombres similares, se unificaron
  // en el atributo JSON 'legal_authorize_first'
  @JsonKey(name: 'legal_authorize_first')
  final String? legalAuthorizeFirst;

  @JsonKey(name: 'legal_authorize_second')
  final String? legalAuthorizeSecond;

  final int? status; // byte en C# se representa como int en Dart

  @JsonKey(name: 'affiliate_type')
  final String? affiliateType;

  final int? father;
  final int? sponsor;
  final bool termsConditions;

  @JsonKey(name: 'beneficiary_email')
  final String? beneficiaryEmail;

  @JsonKey(name: 'beneficiary_phone')
  final String? beneficiaryPhone;

  UpdateAffiliateRequest({
    required this.id,
    this.identification,
    this.name,
    this.userName,
    this.lastName,
    this.address,
    this.legalAuthorizedFirst,
    this.legalAuthorizedSecond,
    this.phone,
    this.email,
    this.zipCode,
    this.country,
    this.statePlace,
    this.city,
    this.birthday,
    this.taxId,
    this.beneficiaryName,
    this.legalAuthorizeFirst,
    this.legalAuthorizeSecond,
    this.status,
    this.affiliateType,
    this.father,
    this.sponsor,
    required this.termsConditions,
    this.beneficiaryEmail,
    this.beneficiaryPhone,
  });

  /// Conecta el constructor `_$$RequestUpdateAffiliateFromJson` generado
  /// al constructor `fromJson`.
  factory UpdateAffiliateRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateAffiliateRequestFromJson(json);

  /// Conecta el método `_$RequestUpdateAffiliateToJson` generado
  /// al método `toJson`.
  Map<String, dynamic> toJson() => _$UpdateAffiliateRequestToJson(this);
}