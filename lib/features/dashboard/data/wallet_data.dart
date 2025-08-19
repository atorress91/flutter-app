import '../domain/entities/transaction.dart';

class WalletData {
  static List<Transaction> getSampleTransactions() {
    return [
      Transaction(
        responsibleUser: 'adminrecycoin',
        affiliate: 'Laurap',
        credit: 0.75,
        debit: 0,
        status: TransactionStatus.atendido,
        concept: 'Comisión pasada a la billetera',
        date: DateTime.parse('2025-08-07T22:41:16.589463Z'),
      ),
      Transaction(
        responsibleUser: 'sistema',
        affiliate: 'N/A',
        credit: 0,
        debit: 50.00,
        status: TransactionStatus.atendido,
        concept: 'Retiro de Saldo Solicitado',
        date: DateTime.parse('2025-08-05T10:20:00Z'),
      ),
      Transaction(
        responsibleUser: 'adminrecycoin',
        affiliate: 'CarlosM',
        credit: 1.50,
        debit: 0,
        status: TransactionStatus.atendido,
        concept: 'Comisión pasada a la billetera',
        date: DateTime.parse('2025-08-02T15:00:00Z'),
      ),
    ];
  }
}
