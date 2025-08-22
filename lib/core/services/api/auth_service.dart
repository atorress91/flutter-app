import '../../data/dtos/users_affiliates_dto.dart';
import '../../data/mappers/user_mapper.dart';
import '../../../features/auth/domain/entities/user.dart';
import '../../data/models/api_response.dart';
import '../../data/request/request_user_auth.dart';
import '../../config/environments.dart';
import 'base_service.dart';

class AuthService extends BaseService {
  AuthService({super.client}) : super(microservice: Microservice.account);

  Future<ApiResponse<User?>> login(RequestUserAuth request) async {
    return postJson<User>(
      '/auth/login',
      request.toJson(),
      fromJson: (json) {
        final userPayload =
            (json as Map<String, dynamic>?)?['affiliate'] ??
            json?['user'] ??
            json;

        if (userPayload is Map<String, dynamic>) {
          final userDto = UsersAffiliatesDto.fromJson(userPayload);
          return UserMapper.fromDto(userDto);
        }

        throw Exception('No se encontraron datos de usuario válidos');
      },
    );
  }
}
