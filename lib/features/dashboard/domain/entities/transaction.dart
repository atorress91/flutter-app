import 'package:my_app/core/data/dtos/wallet_dto.dart';

enum TransactionStatus { atendido, pendiente, fallido }

class Transaction {
  final String responsibleUser;
  final String affiliate;
  final double credit;
  final double debit;
  final TransactionStatus status;
  final String concept;
  final DateTime date;

  Transaction({
    required this.responsibleUser,
    required this.affiliate,
    required this.credit,
    required this.debit,
    required this.status,
    required this.concept,
    required this.date,
  });

  factory Transaction.fromDto(WalletDto dto) {
    return Transaction(
      responsibleUser: dto.adminUserName ?? 'N/A',
      affiliate: dto.affiliateUserName ?? 'N/A',
      credit: dto.credit,
      debit: dto.debit,
      status: dto.status ? TransactionStatus.atendido : TransactionStatus.pendiente,
      concept: dto.concept ?? 'Sin concepto',
      date: dto.date,
    );
  }
}
