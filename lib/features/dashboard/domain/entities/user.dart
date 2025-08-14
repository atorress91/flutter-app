import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String userName;
  final String email;
  final String? fullName;
  final String? imageUrl;
  final bool isActive;

  const User({
    required this.id,
    required this.userName,
    required this.email,
    this.fullName,
    this.imageUrl,
    required this.isActive,
  });

  @override
  List<Object?> get props => [id, userName, email];
}