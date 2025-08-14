enum AppEnvironment { local, prod }

class EnvironmentConfig {
  final String baseUrl;
  final String clientId;

  const EnvironmentConfig({required this.baseUrl, required this.clientId});
}

/// Singleton-like environment holder
class Environment {
  static AppEnvironment _env = AppEnvironment.local; // default

  static EnvironmentConfig _local = const EnvironmentConfig(
    baseUrl: 'http://localhost:3000',
    clientId: 'my-local-client',
  );

  static EnvironmentConfig _prod = const EnvironmentConfig(
    baseUrl: 'https://api.example.com',
    clientId: 'my-prod-client',
  );

  static void set(AppEnvironment env) {
    _env = env;
  }

  static void configure({EnvironmentConfig? local, EnvironmentConfig? prod}) {
    if (local != null) _local = local;
    if (prod != null) _prod = prod;
  }

  static AppEnvironment get current => _env;

  static EnvironmentConfig get config {
    switch (_env) {
      case AppEnvironment.local:
        return _local;
      case AppEnvironment.prod:
        return _prod;
    }
  }

  static String get baseUrl => config.baseUrl;
  static String get clientId => config.clientId;
}
