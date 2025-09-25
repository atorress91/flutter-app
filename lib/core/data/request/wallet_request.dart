import 'package:json_annotation/json_annotation.dart';

part 'wallet_request.g.dart';

@JsonSerializable(includeIfNull: false)
class WalletRequest {
  final int? id;
  final int? status;
  final int affiliateId;
  final String affiliateName;
  final String userPassword;
  final String verificationCode;
  final double amount;
  final String concept;
  final int? retention;
  final bool? isSelected;

  WalletRequest({
    this.id,
    this.status,
    required this.affiliateId,
    required this.affiliateName,
    required this.userPassword,
    required this.verificationCode,
    required this.amount,
    required this.concept,
    this.retention,
    this.isSelected,
  });

  factory WalletRequest.fromJson(Map<String, dynamic> json) =>
      _$WalletRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WalletRequestToJson(this);
}
