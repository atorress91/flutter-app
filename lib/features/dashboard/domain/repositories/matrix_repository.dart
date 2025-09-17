import 'package:my_app/features/dashboard/domain/entities/unilevel_tree.dart';

abstract class MatrixRepository {
  Future<UniLevelTree> getUniLevelTree(int userId);
}
