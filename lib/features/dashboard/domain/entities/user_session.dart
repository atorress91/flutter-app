import '../../../../core/data/dtos/users_affiliates_dto.dart';

class UserSession {
  final UsersAffiliatesDto user;
  final DateTime loggedAt;

  const UserSession({required this.user, required this.loggedAt});

  factory UserSession.fromJson(Map<String, dynamic> json) {
    return UserSession(
      user: UsersAffiliatesDto.fromJson(json['user'] as Map<String, dynamic>),
      loggedAt: DateTime.parse(json['loggedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'user': user.toJson(),
    'loggedAt': loggedAt.toIso8601String(),
  };
}
