import 'package:my_app/core/config/environments.dart';
import 'package:my_app/core/data/dtos/users_affiliates_dto.dart';
import 'package:my_app/core/data/models/api_response.dart';
import 'package:my_app/core/data/request/request_user_auth.dart';
import 'package:my_app/core/data/request/request_user_registration.dart';

import 'base_service.dart';

class AuthService extends BaseService {
  AuthService({super.client}) : super(microservice: Microservice.account);

  Future<ApiResponse<UsersAffiliatesDto?>> login(
    RequestUserAuth request,
  ) async {
    return post<UsersAffiliatesDto?>(
      '/auth/login',
      body: request.toJson(),
      fromJson: (json) {
        if (json == null) {
          return null;
        }

        // Handle different response formats more gracefully
        Map<String, dynamic>? userPayload;
        
        if (json is Map<String, dynamic>) {
          // Try to extract user data from different possible structures
          userPayload = json['affiliate'] as Map<String, dynamic>? ??
                       json['user'] as Map<String, dynamic>? ??
                       json;
        }

        if (userPayload != null && userPayload is Map<String, dynamic>) {
          try {
            return UsersAffiliatesDto.fromJson(userPayload);
          } catch (e) {
            // Log the error but don't throw, return null instead
            print('Error parsing user data: $e');
            print('User payload: $userPayload');
            return null;
          }
        }

        // Don't throw FormatException, return null instead
        print('Unable to extract user payload from response: $json');
        return null;
      },
    );
  }

  Future<ApiResponse<UsersAffiliatesDto?>> register(
    RequestUserRegistration request,
  ) async {
    return post<UsersAffiliatesDto?>(
      '/auth/register',
      body: request.toJson(),
      fromJson: (json) {
        if (json == null) {
          return null;
        }

        final userPayload =
            (json as Map<String, dynamic>?)?['affiliate'] ??
            json?['user'] ??
            json;

        if (userPayload is Map<String, dynamic>) {
          return UsersAffiliatesDto.fromJson(userPayload);
        }

        throw const FormatException(
          'Payload de usuario no encontrado en la respuesta.',
        );
      },
    );
  }
}
