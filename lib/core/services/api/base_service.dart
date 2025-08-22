import 'dart:convert';
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

  /// Headers por defecto, incluyendo X-Client-Id y Authorization por microservicio.
  Map<String, String> defaultHeaders([Map<String, String>? extra]) {
    final key = Environment.serviceKeyFor(microservice);
    return {
      'Content-Type': 'application/json',
      'X-Client-Id': Environment.clientId,
      if (key != null && key.isNotEmpty) 'Authorization': key, // sin "Bearer"
      if (extra != null) ...extra,
    };
  }

  Future<ApiResponse<T?>> _handleResponse<T>(
    Future<http.Response> Function() request, {
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      final response = await request();
      final Map<String, dynamic> body =
          jsonDecode(response.body) as Map<String, dynamic>;

      // Verificar primero si la respuesta fue exitosa
      final bool success = body['success'] is bool
          ? body['success'] as bool
          : true; // por defecto true si no existe el campo

      // Si no es exitoso, retornar directamente sin parsear los datos
      if (!success) {
        return ApiResponse<T?>(
          success: false,
          message: body['message']?.toString() ?? 'La solicitud a la API falló.',
          statusCode: response.statusCode,
          data: null, // No intentar parsear datos cuando hay error
        );
      }

      // Solo si es exitoso, intentar parsear los datos
      final apiResponse = ApiResponse.fromEnvelope(
        envelope: body,
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
    String path, {
    required T Function(dynamic json) fromJson,
    Object? body,
    Map<String, String>? headers,
    Map<String, String>? query,
    Microservice? service,
  }) {
    return _handleResponse<T>(
      () => client.post(
        buildUri(path, query: query, service: service),
        headers: defaultHeaders(headers),
        body: body,
      ),
      fromJson: fromJson,
    );
  }

  Future<ApiResponse<T?>> put<T>(
    String path, {
    required T Function(dynamic json) fromJson,
    Object? body,
    Map<String, String>? headers,
    Map<String, String>? query,
    Microservice? service,
  }) {
    return _handleResponse<T>(
      () => client.put(
        buildUri(path, query: query, service: service),
        headers: defaultHeaders(headers),
        body: body,
      ),
      fromJson: fromJson,
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
        body: body,
      ),
      fromJson: fromJson,
    );
  }

  /// Helper para enviar JSON sin repetir jsonEncode ni content-type.
  Future<ApiResponse<T?>> postJson<T>(
    String path,
    Map<String, dynamic> payload, {
    required T Function(dynamic json) fromJson,
    Map<String, String>? headers,
    Map<String, String>? query,
    Microservice? service,
  }) {
    return _handleResponse<T>(
      () => client.post(
        buildUri(path, query: query, service: service),
        headers: defaultHeaders(headers),
        body: jsonEncode(payload),
      ),
      fromJson: fromJson,
    );
  }
}
