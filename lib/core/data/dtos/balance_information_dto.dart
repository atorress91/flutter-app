import 'package:json_annotation/json_annotation.dart';

part 'balance_information_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BalanceInformationDto {
  @JsonKey(defaultValue: 0)
  final double reverseBalance;

  @JsonKey(defaultValue: 0)
  final double totalAcquisitions;

  @JsonKey(defaultValue: 0)
  final double availableBalance;

  @JsonKey(defaultValue: 0)
  final double totalCommissionsPaid;

  @JsonKey(defaultValue: 0)
  final double serviceBalance;

  @JsonKey(defaultValue: 0)
  final double bonusAmount;

  BalanceInformationDto({
    required this.reverseBalance,
    required this.totalAcquisitions,
    required this.availableBalance,
    required this.totalCommissionsPaid,
    required this.serviceBalance,
    required this.bonusAmount,
  });

  factory BalanceInformationDto.fromJson(Map<String, dynamic> json) =>
      _$BalanceInformationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceInformationDtoToJson(this);
}
