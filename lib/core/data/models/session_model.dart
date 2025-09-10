import 'package:my_app/features/auth/domain/entities/user.dart';

class SessionModel {
  final User user;
  final DateTime loggedAt;

  const SessionModel({required this.user, required this.loggedAt});

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      loggedAt: DateTime.parse(json['loggedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'user': user.toJson(),
    'loggedAt': loggedAt.toIso8601String(),
  };
}
