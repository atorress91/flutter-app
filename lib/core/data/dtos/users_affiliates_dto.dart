class UsersAffiliatesDto {
  final int id;
  final String userName;
  final String email;
  final int isAffiliate;
  final bool status;
  final String? name;
  final String? lastName;
  final String? imageProfileUrl;
  final DateTime createdAt;

  UsersAffiliatesDto({
    required this.id,
    required this.userName,
    required this.email,
    required this.isAffiliate,
    required this.status,
    this.name,
    this.lastName,
    this.imageProfileUrl,
    required this.createdAt,
  });

  factory UsersAffiliatesDto.fromJson(Map<String, dynamic> json) {
    return UsersAffiliatesDto(
      id: json['id'] as int,
      userName: (json['user_name'] ?? '') as String,
      email: (json['email'] ?? '') as String,
      isAffiliate: (json['is_affiliate'] ?? 0) as int,
      status: (json['status'] ?? 0) == 1,
      name: json['name'] as String?,
      lastName: json['last_name'] as String?,
      imageProfileUrl: json['image_profile_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_name': userName,
    'email': email,
    'is_affiliate': isAffiliate,
    'status': status,
    'name': name,
    'last_name': lastName,
    'image_profile_url': imageProfileUrl,
    'created_at': createdAt.toIso8601String(),
  };
}
