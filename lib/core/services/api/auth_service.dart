import 'dart:convert';
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
    final res = await postJson('/auth/login', request.toJson());

    final Map<String, dynamic> body =
        jsonDecode(res.body) as Map<String, dynamic>;

    final initialResponse = ApiResponse<dynamic>.fromEnvelope(
      envelope: body,
      parseData: (json) => json,
      statusCode: res.statusCode,
    );

    if (!initialResponse.success) {
      return ApiResponse<User?>(
        success: false,
        message: initialResponse.message,
        statusCode: initialResponse.statusCode,
        data: null,
      );
    }

    try {
      final userPayload =
          (initialResponse.data as Map<String, dynamic>?)?['affiliate'] ??
          initialResponse.data?['user'] ??
          initialResponse.data;

      if (userPayload is Map<String, dynamic>) {
        final userDto = UsersAffiliatesDto.fromJson(userPayload);
        final userEntity = UserMapper.fromDto(userDto);

        return ApiResponse<User?>(
          success: true,
          data: userEntity,
          statusCode: initialResponse.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse<User?>(
        success: false,
        message: 'Error al procesar los datos del usuario: $e',
        statusCode: initialResponse.statusCode,
        data: null,
      );
    }

    return ApiResponse<User?>(
      success: false,
      message: 'No se encontraron datos de usuario en una respuesta exitosa.',
      statusCode: initialResponse.statusCode,
      data: null,
    );
  }
}
