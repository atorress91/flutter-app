import 'package:my_app/core/config/environments.dart';
import 'package:my_app/core/data/dtos/users_affiliates_dto.dart';
import 'package:my_app/core/data/models/api_response.dart';
import 'package:my_app/core/data/request/request_user_auth.dart';

import 'base_service.dart';

class AuthService extends BaseService {
  AuthService({super.client}) : super(microservice: Microservice.account);

  Future<ApiResponse<UsersAffiliatesDto?>> login(
    RequestUserAuth request,
  ) async {
    return postJson<UsersAffiliatesDto>(
      '/auth/login',
      request.toJson(),
      fromJson: (json) {
        final userPayload =
            (json as Map<String, dynamic>?)?['affiliate'] ??
            json?['user'] ??
            json;

        if (userPayload is Map<String, dynamic>) {
          return UsersAffiliatesDto.fromJson(userPayload);
        }

        throw Exception(
          'No se encontraron datos de usuario válidos en la respuesta.',
        );
      },
    );
  }
}
