class UpdateImageRequest {
  final String imageProfileUrl;

  UpdateImageRequest({required this.imageProfileUrl});

  Map<String, dynamic> toJson() {
    return {'image_profile_url': imageProfileUrl};
  }
}
