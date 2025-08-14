import 'dart:convert';

import '../data/models/api_response.dart';
import '../data/request/request_user_auth.dart';
import '../config/environments.dart';
import 'base_service.dart';

class AuthService extends BaseService {
  AuthService({super.client}) : super(microservice: Microservice.account);

  /// Retorna el "objeto de usuario" que venga en data (user o affiliate) usando ApiResponse.
  Future<ApiResponse<Map<String, dynamic>>> login(
    RequestUserAuth request,
  ) async {
    final res = await postJson('/auth/login', request.toJson());

    if (res.statusCode != 200) {
      throw Exception('Error ${res.statusCode}: ${res.body}');
    }

    // Tipamos explícitamente el body para evitar checks innecesarios
    final Map<String, dynamic> body =
        jsonDecode(res.body) as Map<String, dynamic>;

    // Usamos ApiResponse.fromEnvelope para manejar la respuesta
    return ApiResponse.fromEnvelope(
      envelope: body,
      parseData: (json) {
        // Extrae 'data' si existe, si no, usa el body como tal
        final Object? data =
            json is Map<String, dynamic> && json.containsKey('data')
            ? json['data']
            : json;

        if (data is Map<String, dynamic>) {
          return data;
        } else {
          throw Exception('Formato de respuesta inesperado');
        }
      },
      statusCode: res.statusCode,
    );
  }
}
