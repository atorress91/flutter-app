class ApiResponse<T> {
  final bool success;
  final T data;
  final String? message;
  final int? statusCode;

  const ApiResponse({
    required this.success,
    required this.data,
    this.message,
    this.statusCode,
  });

  factory ApiResponse.fromEnvelope({
    required Map<String, dynamic> envelope,
    required T Function(Object? json) parseData,
    String dataKey = 'data',
    bool defaultSuccess = true,
    int? statusCode,
  }) {
    final bool success = envelope['success'] is bool
        ? envelope['success'] as bool
        : defaultSuccess;

    final Object? rawData = envelope.containsKey(dataKey)
        ? envelope[dataKey]
        : envelope;

    final T data = success ? parseData(rawData) : null as T;
    final String? message = envelope.containsKey('message')
        ? envelope['message']?.toString()
        : null;

    return ApiResponse<T>(
      success: success,
      data: data,
      message: message,
      statusCode: statusCode,
    );
  }
}
