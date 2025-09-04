class WalletDto {
  int id;
  int affiliateId;
  String? affiliateUserName;
  String? adminUserName;
  int userId;
  double credit;
  double debit;
  double? deferred;
  bool status;
  String? concept;
  int? support;
  DateTime date;
  bool compression;
  DateTime? createdAt;
  DateTime? updatedAt;

  WalletDto({
    required this.id,
    required this.affiliateId,
    this.affiliateUserName,
    this.adminUserName,
    required this.userId,
    required this.credit,
    required this.debit,
    this.deferred,
    required this.status,
    this.concept,
    this.support,
    required this.date,
    required this.compression,
    this.createdAt,
    this.updatedAt,
  });


  factory WalletDto.fromJson(Map<String, dynamic> json) {
    return WalletDto(
      id: json['id'] as int,
      affiliateId: json['affiliateId'] as int,
      affiliateUserName: json['affiliateUserName'] as String?,
      adminUserName: json['adminUserName'] as String?,
      userId: json['userId'] as int,
      credit: (json['credit'] as num).toDouble(),
      debit: (json['debit'] as num).toDouble(),
      deferred: json['deferred'] != null ? (json['deferred'] as num).toDouble() : null,
      status: (json['status'] ?? 0) == 1,
      concept: json['concept'] as String?,
      support: json['support'] as int?,
      date: DateTime.parse(json['date'] as String),
      compression: (json['compression'] ?? 0) == 1,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'affiliateId': affiliateId,
    'affiliateUserName': affiliateUserName,
    'adminUserName': adminUserName,
    'userId': userId,
    'credit': credit,
    'debit': debit,
    'deferred': deferred,
    'status': status ? 1 : 0,
    'concept': concept,
    'support': support,
    'date': date.toIso8601String(),
    'compression': compression ? 1 : 0,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}
