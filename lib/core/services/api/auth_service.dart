import 'package:my_app/core/config/environments.dart';
import 'package:my_app/core/data/dtos/users_affiliates_dto.dart';
import 'package:my_app/core/data/models/api_response.dart';
import 'package:my_app/core/data/request/user_auth_request.dart';
import 'package:my_app/core/data/request/user_registration_request.dart';

import 'base_service.dart';

class AuthService extends BaseService {
  AuthService({super.client}) : super(microservice: Microservice.account);

  Future<ApiResponse<UsersAffiliatesDto?>> login(
      UserAuthRequest request,
      ) async {
    return post<UsersAffiliatesDto?>(
      '/auth/login',
      body: request.toJson(),
      fromJson: (json) {
        if (json == null) return null;

        final userData = (json as Map<String, dynamic>?) ?? {};

        return UsersAffiliatesDto.fromJson(userData);
      },

      dataKey: 'data',
    );
  }

  Future<ApiResponse<UsersAffiliatesDto?>> register(
      UserRegistrationRequest request,
      ) async {
    return post<UsersAffiliatesDto?>(
      '/auth/register',
      body: request.toJson(),
      fromJson: (json) {
        if (json == null) return null;
        return UsersAffiliatesDto.fromJson(json as Map<String, dynamic>);
      },
      dataKey: 'affiliate',
    );
  }
}