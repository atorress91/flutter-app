import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:my_app/core/config/environments.dart';
import 'package:my_app/core/data/models/api_response.dart';

abstract class BaseService {
  final http.Client client;
  final Microservice microservice;

  BaseService({http.Client? client, required this.microservice})
    : client = client ?? http.Client();

  String get baseUrl => Environment.baseUrlFor(microservice);

  /// Construye URIs garantizando que no haya doble slash.
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

  /// Headers por defecto, incluye X-Client-Id y Authorization por microservicio.
  Map<String, String> defaultHeaders([Map<String, String>? extra]) {
    final key = Environment.serviceKeyFor(microservice);
    return {
      'Content-Type': 'application/json',
      'X-Client-Id': Environment.clientId,
      if (key != null && key.isNotEmpty) 'Authorization': key,
      if (extra != null) ...extra,
    };
  }

  Future<ApiResponse<T?>> _handleResponse<T>(
      Future<http.Response> Function() request, {
        required T Function(dynamic json) fromJson,
      }) async {
    try {
      final response = await request();
      // 1. Decodifica el JSON sin forzar un tipo específico
      final dynamic decodedBody = jsonDecode(response.body);

      final Map<String, dynamic> envelope;
      bool success = true;

      // 2. Comprueba si la respuesta es un objeto Map o una lista
      if (decodedBody is Map<String, dynamic>) {
        envelope = decodedBody;
        success = envelope['success'] is bool ? envelope['success'] as bool : true;
      } else {
        // 3. Si es una lista, la envuelve en un mapa sintético para mantener la consistencia
        envelope = {'success': true, 'data': decodedBody};
      }

      if (!success) {
        return ApiResponse<T?>(
          success: false,
          message: envelope['message']?.toString() ?? 'La solicitud a la API falló.',
          statusCode: response.statusCode,
          data: null,
        );
      }

      final apiResponse = ApiResponse.fromEnvelope(
        envelope: envelope,
        parseData: fromJson,
        statusCode: response.statusCode,
      );

      return ApiResponse<T?>(
        success: apiResponse.success,
        message: apiResponse.message,
        statusCode: apiResponse.statusCode,
        data: apiResponse.data,
      );
    } catch (e) {
      return ApiResponse<T?>(
        success: false,
        message: 'Error al procesar la respuesta: $e',
        data: null,
      );
    }
  }
  
  Future<ApiResponse<T?>> _handleRequest<T>(
      Future<http.Response> Function() request,
      T Function(dynamic json) fromJson,
      ) async {
    try {
      final response = await request();
      final dynamic jsonBody = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Petición exitosa
        final T data = fromJson(jsonBody);
        return ApiResponse<T?>(
          success: true,
          message: null,
          statusCode: response.statusCode,
          data: data,
        );
      } else {
        // Error manejado por la API (ej. 400, 404, 500)
        final String errorMessage = (jsonBody is Map && jsonBody['message'] != null)
            ? jsonBody['message'].toString()
            : 'Error desconocido';
        return ApiResponse<T?>(
          success: false,
          message: errorMessage,
          statusCode: response.statusCode,
          data: null,
        );
      }
    } on SocketException {
      // Error de conexión
      return ApiResponse<T?>(
        success: false,
        statusCode: 503, // Service Unavailable
        message: 'No se pudo conectar al servidor. Revisa tu conexión a internet.',
        data: null,
      );
    } on FormatException {
      // Error si la respuesta no es un JSON válido
      return ApiResponse<T?>(
        success: false,
        statusCode: 500, // Internal Server Error
        message: 'Respuesta inválida del servidor.',
        data: null,
      );
    } catch (e) {
      // Cualquier otro error inesperado
      return ApiResponse<T?>(
        success: false,
        statusCode: 500,
        message: 'Ocurrió un error inesperado: $e',
        data: null,
      );
    }
  }

  Future<ApiResponse<T?>> get<T>(
    String path, {
    required T Function(dynamic json) fromJson,
    Map<String, String>? headers,
    Map<String, String>? query,
    Microservice? service,
  }) {
    return _handleResponse<T>(
      () => client.get(
        buildUri(path, query: query, service: service),
        headers: defaultHeaders(headers),
      ),
      fromJson: fromJson,
    );
  }

  Future<ApiResponse<T?>> post<T>(
      String endpoint, {
        Object? body,
        required T Function(dynamic json) fromJson,
      }) async {
    return _handleRequest(
      () => client.post(
        buildUri(endpoint),
        headers: defaultHeaders(),
        body: body != null ? json.encode(body) : null,
      ),
      fromJson,
    );
  }

  Future<ApiResponse<T?>> put<T>(
      String endpoint, {
        Object? body,
        required T Function(dynamic json) fromJson,
      }) async {
    return _handleRequest(
      () => client.put(
        buildUri(endpoint),
        headers: defaultHeaders(),
        body: body != null ? json.encode(body) : null,
      ),
      fromJson,
    );
  }

  Future<ApiResponse<T?>> delete<T>(
    String path, {
    required T Function(dynamic json) fromJson,
    Object? body,
    Map<String, String>? headers,
    Map<String, String>? query,
    Microservice? service,
  }) {
    return _handleResponse<T>(
      () => client.delete(
        buildUri(path, query: query, service: service),
        headers: defaultHeaders(headers),
        body: body != null ? jsonEncode(body) : null,
      ),
      fromJson: fromJson,
    );
  }
}
