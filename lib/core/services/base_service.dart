import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/environments.dart';

/// Servicio base para centralizar baseUrl, cliente HTTP y headers comunes.
abstract class BaseService {
  final http.Client client;
  final Microservice microservice;

  BaseService({http.Client? client, required this.microservice})
      : client = client ?? http.Client();

  String get baseUrl => Environment.baseUrlFor(microservice);

  /// Construye URIs garantizando que no haya doble slash.
  Uri buildUri(String path, {Map<String, String>? query, Microservice? service}) {
    final base = Environment.baseUrlFor(service ?? microservice);
    final normalizedBase = base.endsWith('/') ? base.substring(0, base.length - 1) : base;
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    final uri = Uri.parse('$normalizedBase$normalizedPath');
    return query == null ? uri : uri.replace(queryParameters: query);
  }

  /// Headers por defecto, incluyendo X-Client-Id desde environments.
  Map<String, String> defaultHeaders([Map<String, String>? extra]) => {
        'Content-Type': 'application/json',
        'X-Client-Id': Environment.clientId,
        if (extra != null) ...extra,
      };

  Future<http.Response> get(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? query,
    Microservice? service,
  }) {
    return client.get(
      buildUri(path, query: query, service: service),
      headers: defaultHeaders(headers),
    );
  }

  Future<http.Response> post(
    String path, {
    Object? body,
    Map<String, String>? headers,
    Map<String, String>? query,
    Microservice? service,
  }) {
    return client.post(
      buildUri(path, query: query, service: service),
      headers: defaultHeaders(headers),
      body: body,
    );
  }

  Future<http.Response> put(
    String path, {
    Object? body,
    Map<String, String>? headers,
    Map<String, String>? query,
    Microservice? service,
  }) {
    return client.put(
      buildUri(path, query: query, service: service),
      headers: defaultHeaders(headers),
      body: body,
    );
  }

  Future<http.Response> delete(
    String path, {
    Object? body,
    Map<String, String>? headers,
    Map<String, String>? query,
    Microservice? service,
  }) {
    return client.delete(
      buildUri(path, query: query, service: service),
      headers: defaultHeaders(headers),
      body: body,
    );
  }

  /// Helper para enviar JSON sin repetir jsonEncode ni content-type.
  Future<http.Response> postJson(String path, Map<String, dynamic> payload,
      {Map<String, String>? headers, Map<String, String>? query, Microservice? service}) {
    return post(
      path,
      body: jsonEncode(payload),
      headers: defaultHeaders(headers),
      query: query,
      service: service,
    );
  }
}
