enum AppEnvironment { local, prod }

enum Microservice { account, systemConfiguration, inventory, wallet }

class EnvironmentConfig {
  final Map<Microservice, String> endpoints;
  final String clientId;

  const EnvironmentConfig({
    required this.endpoints,
    required this.clientId,
  });
}

/// Singleton-like environment holder
class Environment {
  static AppEnvironment _env = AppEnvironment.local; // default

  static EnvironmentConfig _local = EnvironmentConfig(
    endpoints: {
      Microservice.account: 'http://localhost:3000',
      Microservice.systemConfiguration: 'http://localhost:3001',
      Microservice.inventory: 'http://localhost:3002',
      Microservice.wallet: 'http://localhost:3003',
    },
    clientId: 'my-local-client',
  );

  static EnvironmentConfig _prod = EnvironmentConfig(
    endpoints: {
      Microservice.account: 'https://api.example.com/account',
      Microservice.systemConfiguration: 'https://api.example.com/system',
      Microservice.inventory: 'https://api.example.com/inventory',
      Microservice.wallet: 'https://api.example.com/wallet',
    },
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

  static String baseUrlFor(Microservice service) => config.endpoints[service] ?? '';
  static String get clientId => config.clientId;
}
