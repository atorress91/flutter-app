import 'package:my_app/core/config/environments.dart';
import 'package:my_app/core/data/dtos/user_unilevel_tree_dto.dart';

import 'package:my_app/core/data/models/api_response.dart';
import 'package:my_app/core/services/api/base_service.dart';

class MatrixService extends BaseService {
  MatrixService({super.client}) : super(microservice: Microservice.wallet);

  Future<ApiResponse<UserUniLevelTreeDto?>> getUniLevelTree(int userId) async {
    return get<UserUniLevelTreeDto?>(
      '/matrix/uni_level',
      query: {'userId': userId.toString()},
      fromJson: (json) {
        if (json == null) return null;

        if (json is Map<String, dynamic>) {
          return UserUniLevelTreeDto.fromJson(json);
        }

        throw Exception(
          'Formato de datos inválido para la información del balance',
        );
      },
    );
  }
}
