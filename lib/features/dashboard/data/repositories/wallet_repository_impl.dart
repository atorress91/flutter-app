import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/core/services/api/wallet_service.dart';
import 'package:my_app/features/dashboard/domain/entities/transaction.dart';
import 'package:my_app/features/dashboard/domain/repositories/wallet_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletService _walletService;

  WalletRepositoryImpl(this._walletService);

  @override
  Future<List<Transaction>> getWalletTransactions(int userId) async {
    final response = await _walletService.getWalletByAffiliateId(userId);

    if (response.success && response.data != null) {
      return response.data!.map((dto) => Transaction.fromDto(dto)).toList();
    } else {
      throw ApiException(
        response.message ?? 'Error al obtener las transacciones de la billetera',
      );
    }
  }
}
