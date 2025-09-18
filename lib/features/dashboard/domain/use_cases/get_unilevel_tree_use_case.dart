import 'package:my_app/features/dashboard/domain/entities/client.dart';
import 'package:my_app/features/dashboard/domain/repositories/matrix_repository.dart';

class GetUniLevelTreeUseCase {
  final MatrixRepository _matrixRepository;

  GetUniLevelTreeUseCase(this._matrixRepository);

  Future<Client> execute({required int userId}) async {
    return await _matrixRepository.getUniLevelTree(userId);
  }
}
