import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String userName;
  final String email;
  final String? fullName;
  final String? imageUrl;
  final bool isActive;
  final DateTime createdAt;
  final String? roleName;
  final String? phone;

  const User({
    required this.id,
    required this.userName,
    required this.email,
    this.fullName,
    this.imageUrl,
    required this.isActive,
    required this.createdAt,
    this.roleName,
    this.phone,
  });

  @override
  List<Object?> get props => [id, userName, email];
}
