class UpdateImageRequest {
  final int userId;
  final String imageIdPath;

  UpdateImageRequest({required this.userId, required this.imageIdPath});

  Map<String, dynamic> toJson() {
    return {'id': userId, 'image_id_path': imageIdPath};
  }
}
