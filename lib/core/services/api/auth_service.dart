import 'dart:convert';

import '../../data/models/api_response.dart';
import '../../data/request/request_user_auth.dart';
import '../../config/environments.dart';
import 'base_service.dart';

class AuthService extends BaseService {
  AuthService({super.client}) : super(microservice: Microservice.account);

  Future<ApiResponse<Map<String, dynamic>>> login(
    RequestUserAuth request,
  ) async {
    final res = await postJson('/auth/login', request.toJson());

    final Map<String, dynamic> body =
        jsonDecode(res.body) as Map<String, dynamic>;

    return ApiResponse.fromEnvelope(
      envelope: body,
      parseData: (json) {
        if (json is Map<String, dynamic>) {
          return json;
        }

        return <String, dynamic>{};
      },
      statusCode: res.statusCode,
    );
  }
}
