import 'package:my_app/core/data/dtos/wallet_dto.dart';
import 'package:my_app/features/dashboard/domain/entities/transaction.dart';

class TransactionMapper {
  static Transaction fromDto(WalletDto dto) {
    return Transaction(
      responsibleUser: dto.adminUserName ?? 'N/A',
      affiliate: dto.affiliateUserName ?? 'N/A',
      credit: dto.credit,
      debit: dto.debit,
      status: dto.status == true ? TransactionStatus.atendido: TransactionStatus.pendiente,
      concept: dto.concept ?? 'N/A',
      date: dto.createdAt ?? DateTime.now(),
    );
  }
}
