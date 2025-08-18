import '../../../features/auth/domain/entities/user.dart';

class UserDto {
  final int id;
  final int roleId;
  final int isAffiliate;
  final String rolName;
  final String userName;
  final String? name;
  final String? lastName;
  final String email;
  final String phone;
  final String address;
  final bool status;
  final String token;
  final String? imageProfileUrl;
  final DateTime createdAt;

  UserDto({
    required this.id,
    required this.roleId,
    required this.isAffiliate,
    required this.rolName,
    required this.userName,
    this.name,
    this.lastName,
    required this.email,
    required this.phone,
    required this.address,
    required this.status,
    required this.token,
    this.imageProfileUrl,
    required this.createdAt,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as int,
      roleId: (json['role_id'] ?? 0) as int,
      isAffiliate: (json['is_affiliate'] ?? 0) as int,
      rolName: (json['rol_name'] ?? '') as String,
      userName: (json['user_name'] ?? '') as String,
      name: json['name'] as String?,
      lastName: json['last_name'] as String?,
      email: (json['email'] ?? '') as String,
      phone: (json['phone'] ?? '') as String,
      address: (json['address'] ?? '') as String,
      status: (json['status'] ?? 0) == 1,
      token: (json['token'] ?? '') as String,
      imageProfileUrl: json['image_profile_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'role_id': roleId,
    'is_affiliate': isAffiliate,
    'rol_name': rolName,
    'user_name': userName,
    'name': name,
    'last_name': lastName,
    'email': email,
    'phone': phone,
    'address': address,
    'status': status ? 1 : 0,
    'token': token,
    'image_profile_url': imageProfileUrl,
    'created_at': createdAt.toIso8601String(),
  };

  User toEntity() {
    return User(
      id: id,
      roleName: rolName,
      userName: userName,
      fullName: (name != null && lastName != null) ? '$name $lastName' : name,
      email: email,
      phone: phone,
      imageUrl: imageProfileUrl,
      createdAt: createdAt,
      isActive: status,
    );
  }
}
