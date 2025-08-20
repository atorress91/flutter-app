import 'package:my_app/features/dashboard/domain/entities/balance_information.dart';

abstract class BalanceRepository {
  Future<BalanceInformation> getBalanceInformation(int userId);
}
