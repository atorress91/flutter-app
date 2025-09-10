import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:my_app/core/config/environments.dart';
import 'package:my_app/core/data/models/api_response.dart';

/// Tipo de función para parsear respuestas JSON
typedef JsonParser<T> = T Function(Object? json);

abstract class BaseService {
  final http.Client client;
  final Microservice microservice;

  BaseService({
    http.Client? client,
    required this.microservice,
  }) : client = client ?? http.Client();

  String get baseUrl => Environment.baseUrlFor(microservice);

  /// Construye URIs garantizando que no haya doble slash
  Uri buildUri(
      String path, {
        Map<String, String>? query,
        Microservice? service,
      }) {
    final base = Environment.baseUrlFor(service ?? microservice);
    final normalizedBase = base.endsWith('/')
        ? base.substring(0, base.length - 1)
        : base;
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    final uri = Uri.parse('$normalizedBase$normalizedPath');
    return query == null ? uri : uri.replace(queryParameters: query);
  }

  /// Headers por defecto con autenticación por microservicio
  Map<String, String> defaultHeaders([Map<String, String>? extra]) {
    final key = Environment.serviceKeyFor(microservice);
    return {
      'Content-Type': 'application/json',
      'X-Client-Id': Environment.clientId,
      if (key != null && key.isNotEmpty) 'Authorization': key,
      if (extra != null) ...extra,
    };
  }

  Future<ApiResponse<T?>> _handleRequest<T>(
      Future<http.Response> Function() request, {
        required JsonParser<T?> fromJson,
        String dataKey = 'data',
        bool defaultSuccess = true,
      }) async {
    try {
      final response = await request();

      // Verificar errores del servidor primero
      if (response.statusCode >= 500) {
        return ApiResponse<T?>(
          success: false,
          statusCode: response.statusCode,
          message: 'Error del servidor. Por favor, intenta más tarde.',
          data: null,
        );
      }

      // Decodificar el body
      final dynamic decodedBody = _decodeBody(response.body);

      // Normalizar la respuesta a un envelope consistente
      final envelope = _normalizeResponse(decodedBody);

      // Usar ApiResponse.fromEnvelope para crear la respuesta
      return ApiResponse.fromEnvelope(
        envelope: envelope,
        parseData: fromJson,
        dataKey: dataKey,
        defaultSuccess: defaultSuccess,
        statusCode: response.statusCode,
      );

    } on SocketException {
      return ApiResponse<T?>(
        success: false,
        statusCode: 503,
        message: 'No se pudo conectar al servidor. Revisa tu conexión a internet.',
        data: null,
      );
    } on FormatException catch (e) {
      return ApiResponse<T?>(
        success: false,
        statusCode: 500,
        message: 'Respuesta inválida del servidor: ${e.message}',
        data: null,
      );
    } catch (e) {
      return ApiResponse<T?>(
        success: false,
        statusCode: 500,
        message: 'Ocurrió un error inesperado: $e',
        data: null,
      );
    }
  }

  /// Decodifica el body de la respuesta
  dynamic _decodeBody(String body) {
    if (body.isEmpty) {
      return <String, dynamic>{};
    }
    return jsonDecode(body);
  }

  /// Normaliza la respuesta a un formato consistente de envelope
  Map<String, dynamic> _normalizeResponse(dynamic decodedBody) {
    if (decodedBody is Map<String, dynamic>) {
      return decodedBody;
    } else if (decodedBody is List) {
      // Si es una lista, la envuelve en un envelope sintético
      return {
        'success': true,
        'data': decodedBody,
      };
    } else {
      // Para otros tipos primitivos
      return {
        'success': true,
        'data': decodedBody,
      };
    }
  }

  /// Ejecuta una petición GET
  Future<ApiResponse<T?>> get<T>(
      String path, {
        required JsonParser<T?> fromJson,
        Map<String, String>? headers,
        Map<String, String>? query,
        Microservice? service,
        String dataKey = 'data',
      }) {
    return _handleRequest<T>(
          () => client.get(
        buildUri(path, query: query, service: service),
        headers: defaultHeaders(headers),
      ),
      fromJson: fromJson,
      dataKey: dataKey,
    );
  }

  /// Ejecuta una petición POST
  Future<ApiResponse<T?>> post<T>(
      String endpoint, {
        Object? body,
        required JsonParser<T?> fromJson,
        Map<String, String>? headers,
        String dataKey = 'data',
      }) {
    return _handleRequest<T>(
          () => client.post(
        buildUri(endpoint),
        headers: defaultHeaders(headers),
        body: body != null ? jsonEncode(body) : null,
      ),
      fromJson: fromJson,
      dataKey: dataKey,
    );
  }

  /// Ejecuta una petición PUT
  Future<ApiResponse<T?>> put<T>(
      String endpoint, {
        Object? body,
        required JsonParser<T?> fromJson,
        Map<String, String>? headers,
        String dataKey = 'data',
      }) {
    return _handleRequest<T>(
          () => client.put(
        buildUri(endpoint),
        headers: defaultHeaders(headers),
        body: body != null ? jsonEncode(body) : null,
      ),
      fromJson: fromJson,
      dataKey: dataKey,
    );
  }

  /// Ejecuta una petición DELETE
  Future<ApiResponse<T?>> delete<T>(
      String path, {
        required JsonParser<T?> fromJson,
        Object? body,
        Map<String, String>? headers,
        Map<String, String>? query,
        Microservice? service,
        String dataKey = 'data',
      }) {
    return _handleRequest<T>(
          () => client.delete(
        buildUri(path, query: query, service: service),
        headers: defaultHeaders(headers),
        body: body != null ? jsonEncode(body) : null,
      ),
      fromJson: fromJson,
      dataKey: dataKey,
    );
  }

  /// Ejecuta una petición PATCH
  Future<ApiResponse<T?>> patch<T>(
      String endpoint, {
        Object? body,
        required JsonParser<T?> fromJson,
        Map<String, String>? headers,
        String dataKey = 'data',
      }) {
    return _handleRequest<T>(
          () => client.patch(
        buildUri(endpoint),
        headers: defaultHeaders(headers),
        body: body != null ? jsonEncode(body) : null,
      ),
      fromJson: fromJson,
      dataKey: dataKey,
    );
  }
}