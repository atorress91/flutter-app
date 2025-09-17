import 'package:my_app/features/dashboard/domain/entities/unilevel_tree.dart';
import 'package:my_app/features/dashboard/domain/repositories/matrix_repository.dart';

class GetUniLevelTreeUseCase {
  final MatrixRepository _matrixRepository;

  GetUniLevelTreeUseCase(this._matrixRepository);

  Future<UniLevelTree> execute({required int userId}) async {
    return await _matrixRepository.getUniLevelTree(userId);
  }
}
