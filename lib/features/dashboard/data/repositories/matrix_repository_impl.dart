import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/core/services/api/matrix_service.dart';
import 'package:my_app/features/dashboard/data/mappers/unilevel_mapper.dart';
import 'package:my_app/features/dashboard/domain/entities/unilevel_tree.dart';
import 'package:my_app/features/dashboard/domain/repositories/matrix_repository.dart';

class MatrixRepositoryImpl implements MatrixRepository {
  final MatrixService _matrixService;

  MatrixRepositoryImpl(this._matrixService);

  @override
  Future<UniLevelTree> getUniLevelTree(int userId) async {
    final response = await _matrixService.getUniLevelTree(userId);

    if(response.success && response.data != null){
      return UniLevelMapper.fromDto(response.data!);
    } else {
      throw ApiException(response.message ?? 'Error al obtener el árbol unilevel');
    }
  }
}
