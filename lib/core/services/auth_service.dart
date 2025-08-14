import 'dart:convert';
import 'package:http/http.dart' as http;

import '../data/request/request_user_auth.dart';

class AuthService {
  final String baseUrl;
  final http.Client _client;

  AuthService(this.baseUrl, {http.Client? client})
    : _client = client ?? http.Client();

  /// Retorna el "objeto de usuario" que venga en data (user o affiliate) o lanza excepción en Fail.
  Future<Map<String, dynamic>> login(RequestUserAuth request) async {
    final url = Uri.parse(
      '$baseUrl/auth/login',
    ); // ajusta prefijo /api/v1 si aplica
    final res = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (res.statusCode != 200) {
      throw Exception('Error ${res.statusCode}: ${res.body}');
    }

    // Tipamos explícitamente el body para evitar checks innecesarios
    final Map<String, dynamic> body =
        jsonDecode(res.body) as Map<String, dynamic>;

    // Intentamos detectar un envelope típico: { success: bool, data: {...}, message: "..." }
    final bool success = body['success'] is bool
        ? body['success'] as bool
        : true;
    if (!success) {
      final msg = (body['message'] ?? 'Login fallido').toString();
      throw Exception(msg);
    }

    // Extrae 'data' si existe, si no, usa el body como tal
    final Object? data = body.containsKey('data') ? body['data'] : body;

    if (data is Map<String, dynamic>) {
      return data;
    } else {
      throw Exception('Formato de respuesta inesperado');
    }
  }
}
