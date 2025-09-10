import 'package:json_annotation/json_annotation.dart';

part 'update_image_request.g.dart';

@JsonSerializable()
class UpdateImageRequest {
  @JsonKey(name: 'image_profile_url')
  final String imageProfileUrl;

  UpdateImageRequest({required this.imageProfileUrl});

  factory UpdateImageRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateImageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateImageRequestToJson(this);
}
