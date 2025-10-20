import 'package:my_app/features/dashboard/domain/entities/client.dart';

abstract class MatrixRepository {
  Future<Client> getUniLevelTree(int userId);
  Future<bool> hasReachedWithdrawalLimit(int userId);
}
