class UsersAffiliatesDto {
  final int id;
  final String userName;
  final String email;
  final int isAffiliate;
  final int status;
  final String? name;
  final String? lastName;
  final String? imageProfileUrl;

  UsersAffiliatesDto({
    required this.id,
    required this.userName,
    required this.email,
    required this.isAffiliate,
    required this.status,
    this.name,
    this.lastName,
    this.imageProfileUrl,
  });

  factory UsersAffiliatesDto.fromJson(Map<String, dynamic> json) {
    return UsersAffiliatesDto(
      id: json['id'] as int,
      userName: (json['user_name'] ?? '') as String,
      email: (json['email'] ?? '') as String,
      isAffiliate: (json['is_affiliate'] ?? 0) as int,
      status: (json['status'] ?? 0) as int,
      name: json['name'] as String?,
      lastName: json['last_name'] as String?,
      imageProfileUrl: json['image_profile_url'] as String?,
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
  };

  User toEntity() {
    return User(
      id: id,
      userName: userName,
      email: email,
      // Lógica de mapeo: combina nombre y apellido
      fullName: (name != null && lastName != null) ? '$name $lastName' : name,
      imageUrl: imageProfileUrl,
      isActive: status == 1,
    );
  }
}
