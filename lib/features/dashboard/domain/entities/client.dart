import 'package:equatable/equatable.dart';

class Client extends Equatable {
  final String username;
  final int id;
  final int level;
  final int father;
  final String description;
  final String image;
  final int byte;
  final List<Client> referrals;

  const Client({
    required this.username,
    required this.id,
    required this.level,
    required this.father,
    required this.description,
    required this.image,
    required this.byte,
    this.referrals = const [],
  });

  @override
  List<Object?> get props => [
    username,
    id,
    level,
    father,
    description,
    image,
    byte,
    referrals
  ];
}
