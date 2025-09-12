import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String userName;
  final String identification;
  final String email;
  final String? fullName;
  final String? name;
  final String? lastName;
  final String? imageUrl;
  final bool isActive;
  final DateTime createdAt;
  final String? roleName;
  final String? phone;
  final bool isAffiliate;
  final DateTime? birthDay;
  final String? address;
  final String? beneficiaryName;
  final String? beneficiaryEmail;
  final String? beneficiaryPhone;

  const User({
    required this.id,
    required this.userName,
    required this.identification,
    required this.email,
    this.fullName,
    this.name,
    this.lastName,
    this.imageUrl,
    required this.isActive,
    required this.createdAt,
    this.roleName,
    this.phone,
    required this.isAffiliate,
    this.birthDay,
    this.address,
    this.beneficiaryName,
    this.beneficiaryEmail,
    this.beneficiaryPhone,
  });

  @override
  List<Object?> get props => [id, identification, userName, email, isAffiliate,phone, address];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      userName: json['userName'] as String,
      identification: json['identification'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String?,
      name: json['name'] as String?,
      lastName: json['lastName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      roleName: json['roleName'] as String?,
      phone: json['phone'] as String?,
      isAffiliate: json['isAffiliate'] as bool,
      birthDay: json['birthday'] != null ? DateTime.parse(json['birthday'] as String) : null,
      address: json['address'] as String?,
      beneficiaryName: json['beneficiary_name'] as String?,
      beneficiaryEmail: json['beneficiary_email'] as String?,
      beneficiaryPhone: json['beneficiary_phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'identification': identification,
      'email': email,
      'fullName': fullName,
      'name': name,
      'lastName': lastName,
      'imageUrl': imageUrl,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'roleName': roleName,
      'phone': phone,
      'isAffiliate': isAffiliate,
      'birthday': birthDay?.toIso8601String(),
      'address': address,
      'beneficiary_name': beneficiaryName,
      'beneficiary_email': beneficiaryEmail,
      'beneficiary_phone': beneficiaryPhone,
    };
  }
}
