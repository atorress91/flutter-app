import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String userName;
  final String identification;
  final String email;
  final String? fullName;
  final String? imageUrl;
  final bool isActive;
  final DateTime createdAt;
  final String? roleName;
  final String? phone;
  final bool isAffiliate;
  final DateTime? birthDay;

  const User({
    required this.id,
    required this.userName,
    required this.identification,
    required this.email,
    this.fullName,
    this.imageUrl,
    required this.isActive,
    required this.createdAt,
    this.roleName,
    this.phone,
    required this.isAffiliate,
    this.birthDay
  });

  @override
  List<Object?> get props => [id, identification, userName, email, isAffiliate];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      userName: json['userName'] as String,
      identification: json['identification'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      roleName: json['roleName'] as String?,
      phone: json['phone'] as String?,
      isAffiliate: json['isAffiliate'] as bool,
      birthDay: json['birthDay'] != null ? DateTime.parse(json['birthDay'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'identification': identification,
      'email': email,
      'fullName': fullName,
      'imageUrl': imageUrl,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'roleName': roleName,
      'phone': phone,
      'isAffiliate': isAffiliate,
      'birthDay': birthDay?.toIso8601String(),
    };
  }
}
