enum TransactionStatus { Atendido, Pendiente, Fallido }

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
}
