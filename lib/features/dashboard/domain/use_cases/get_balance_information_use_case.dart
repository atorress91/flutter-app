import 'package:my_app/features/dashboard/domain/entities/balance_information.dart';
import 'package:my_app/features/dashboard/domain/repositories/balance_repository.dart';

class GetBalanceInformationUseCase {
  final BalanceRepository _balanceRepository;

  GetBalanceInformationUseCase(this._balanceRepository);

  Future<BalanceInformation> execute({required int userId}) async {
    return await _balanceRepository.getBalanceInformation(userId);
  }
}
