import 'package:equatable/equatable.dart';

enum TransactionStatus { atendido, pendiente }

class Transaction extends Equatable {
  final String responsibleUser;
  final String affiliate;
  final double credit;
  final double debit;
  final TransactionStatus status;
  final String concept;
  final DateTime date;

  const Transaction({
    required this.responsibleUser,
    required this.affiliate,
    required this.credit,
    required this.debit,
    required this.status,
    required this.concept,
    required this.date,
  });

  @override
  List<Object?> get props => [
    responsibleUser,
    affiliate,
    credit,
    debit,
    status,
    concept,
    date,
  ];
}
