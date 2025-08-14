enum AppEnvironment { local, prod }

enum Microservice { account, systemConfiguration, inventory, wallet }

class EnvironmentConfig {
  final Map<Microservice, String> endpoints;
  final Map<Microservice, String>
  serviceKeys; // llaves por microservicio para Authorization
  final String clientId;

  const EnvironmentConfig({
    required this.endpoints,
    required this.clientId,
    this.serviceKeys = const {},
  });
}

/// Singleton-like environment holder
class Environment {
  static AppEnvironment _env = AppEnvironment.local; // default

  static EnvironmentConfig _local = EnvironmentConfig(
    endpoints: {
      Microservice.account: 'https://account.recycoin.net/api/v1',
      Microservice.systemConfiguration: 'http://localhost:3001',
      Microservice.inventory: 'http://localhost:3002',
      Microservice.wallet: 'http://localhost:3003',
    },
    clientId: 'my-local-client',
    serviceKeys: const {}, // por defecto vacío
  );

  static EnvironmentConfig _prod = EnvironmentConfig(
    endpoints: {
      Microservice.account: 'https://account.recycoin.net/api/v1',
      Microservice.systemConfiguration: 'https://api.example.com/system',
      Microservice.inventory: 'https://api.example.com/inventory',
      Microservice.wallet: 'https://api.example.com/wallet',
    },
    clientId: 'my-prod-client',
    serviceKeys: const {}, // por defecto vacío
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

  static String baseUrlFor(Microservice service) =>
      config.endpoints[service] ?? '';

  static String get clientId => config.clientId;

  // Devuelve la llave del microservicio para Authorization (si existe)
  static String? serviceKeyFor(Microservice service) =>
      config.serviceKeys[service];
}
