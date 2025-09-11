import 'package:json_annotation/json_annotation.dart';

part 'balance_information_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BalanceInformationDto {
  @JsonKey(name: 'reverseBalance',defaultValue: 0)
  final double reverseBalance;

  @JsonKey(name: 'totalAcquisitions',defaultValue: 0)
  final double totalAcquisitions;

  @JsonKey(name: 'availableBalance',defaultValue: 0)
  final double availableBalance;

  @JsonKey(name:'totalCommissionsPaid',defaultValue: 0)
  final double totalCommissionsPaid;

  @JsonKey(name:'serviceBalance',defaultValue: 0)
  final double serviceBalance;

  @JsonKey(name:'bonusAmount',defaultValue: 0)
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
