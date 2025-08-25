import 'package:my_app/features/dashboard/data/mappers/balance_information_mapper.dart';
import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/core/services/api/wallet_service.dart';
import 'package:my_app/features/dashboard/domain/entities/balance_information.dart';
import 'package:my_app/features/dashboard/domain/repositories/balance_repository.dart';

class BalanceRepositoryImpl implements BalanceRepository {
  final WalletService _walletService;

  BalanceRepositoryImpl(this._walletService);

  @override
  Future<BalanceInformation> getBalanceInformation(int userId) async {
    final response = await _walletService.getBalanceInformationByUserId(userId);

    if (response.success && response.data != null) {
      return BalanceInformationMapper.fromDto(response.data!);
    } else {
      throw ApiException(
        response.message ?? 'Error al obtener la información del balance',
      );
    }
  }
}
