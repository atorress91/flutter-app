import 'package:json_annotation/json_annotation.dart';
import 'package:my_app/core/data/dtos/purchase_dto.dart';

part 'network_info_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class NetworkInfoDto {
  @JsonKey(defaultValue: [])
  final List<PurchaseDto> currentYearPurchases;

  @JsonKey(defaultValue: [])
  final List<PurchaseDto> previousYearPurchases;

  NetworkInfoDto({
    required this.currentYearPurchases,
    required this.previousYearPurchases,
  });

  factory NetworkInfoDto.fromJson(Map<String, dynamic> json) =>
      _$NetworkInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkInfoDtoToJson(this);
}
