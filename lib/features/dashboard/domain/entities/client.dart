class Client {
  final String id;
  final String name;
  final String avatarUrl;
  final DateTime joinDate;
  final List<Client> referrals;

  Client({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.joinDate,
    this.referrals = const [],
  });
}