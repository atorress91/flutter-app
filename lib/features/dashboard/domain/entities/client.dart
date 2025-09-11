import 'package:equatable/equatable.dart';

class Client extends Equatable {
  final String id;
  final String name;
  final String avatarUrl;
  final DateTime joinDate;
  final List<Client> referrals;

  const Client({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.joinDate,
    this.referrals = const [],
  });

  @override
  List<Object?> get props => [
    id,
    name,
    avatarUrl,
    joinDate,
    referrals
  ];
}
