import 'package:my_app/features/dashboard/domain/repositories/matrix_repository.dart';

class HasReachedWithdrawalLimitUseCase {
  final MatrixRepository matrixRepository;

  HasReachedWithdrawalLimitUseCase(this.matrixRepository);

  Future<bool> execute(int userId) {
    return matrixRepository.hasReachedWithdrawalLimit(userId);
  }
}