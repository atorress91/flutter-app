class UpdateImageRequest {
  final int userId;
  final String imageProfileUrl;

  UpdateImageRequest({required this.userId, required this.imageProfileUrl});

  Map<String, dynamic> toJson() {
    return {'id': userId, 'image_profile_url': imageProfileUrl};
  }
}
