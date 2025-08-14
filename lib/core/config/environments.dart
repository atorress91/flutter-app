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
    clientId: 'eco-keyhFvQoUOk=r6/F!chia2Fe1-8OU?4YNWqAVWlaiN!tYrWIdvoUMv8Q6d6',
    serviceKeys: const {}, // por defecto vacío
  );

  static EnvironmentConfig _prod = EnvironmentConfig(
    endpoints: {
      Microservice.account: 'https://account.recycoin.net/api/v1',
      Microservice.systemConfiguration: 'https://api.example.com/system',
      Microservice.inventory: 'https://api.example.com/inventory',
      Microservice.wallet: 'https://api.example.com/wallet',
    },
    clientId: 'eco-keyhFvQoUOk=r6/F!chia2Fe1-8OU?4YNWqAVWlaiN!tYrWIdvoUMv8Q6d6',
    serviceKeys: const {}, // por defecto vacío
  );

  static void set(AppEnvironment env) {
    _env = env;
  }

  static void configure({EnvironmentConfig? local, EnvironmentConfig? prod}) {
    if (local != null) _local = local;
    if (prod != null) _prod = prod;
  }

  /// Configura el entorno de desarrollo local
  static void configureLocal() {
    set(AppEnvironment.local);
    configure(
      local: EnvironmentConfig(
        endpoints: {
          Microservice.account: 'https://account.recycoin.net/api/v1',
          Microservice.systemConfiguration: 'http://localhost:3001',
          Microservice.inventory: 'http://localhost:3002',
          Microservice.wallet: 'http://localhost:3003',
        },
        clientId: 'eco-keyhFvQoUOk=r6/F!chia2Fe1-8OU?4YNWqAVWlaiN!tYrWIdvoUMv8Q6d6',
        serviceKeys: {
          Microservice.account: 'eco-keygJ-MrM8y9jUD/b1dN24=neYjxeUA=N-f?9sHuDCcJ0JWfx-ajo7yjVn441',
          Microservice.systemConfiguration: 'eco-key8ZgMhRytu-Jrv1FU1rZSw2jM-FaBP!ou!sJNBITT3tA63GBrrQiVe3zvS',
          Microservice.inventory: 'eco-keyLd5DU5faBWLfLrE1ATUK0c1qpvSci1x5TvFkDVw3FEM7JO30Jm!zXyB4w',
          Microservice.wallet: 'eco-keypFvQnUOko=r4/G!chia5Fe2-6OU?2YNYqAPWlaiN!uYrZIdwoUNv9P4d7',
        },
      ),
    );
  }

  /// Configura el entorno de producción
  static void configureProduction() {
    set(AppEnvironment.prod);
    configure(
      prod: EnvironmentConfig(
        endpoints: {
          Microservice.account: 'https://account.recycoin.net/api/v1',
          Microservice.systemConfiguration: 'https://api.example.com/system',
          Microservice.inventory: 'https://api.example.com/inventory',
          Microservice.wallet: 'https://api.example.com/wallet',
        },
        clientId: 'eco-keyhFvQoUOk=r6/F!chia2Fe1-8OU?4YNWqAVWlaiN!tYrWIdvoUMv8Q6d6',
        serviceKeys: {
          Microservice.account: 'eco-keygJ-MrM8y9jUD/b1dN24=neYjxeUA=N-f?9sHuDCcJ0JWfx-ajo7yjVn441',
          Microservice.systemConfiguration: 'eco-key8ZgMhRytu-Jrv1FU1rZSw2jM-FaBP!ou!sJNBITT3tA63GBrrQiVe3zvS',
          Microservice.inventory: 'eco-keyLd5DU5faBWLfLrE1ATUK0c1qpvSci1x5TvFkDVw3FEM7JO30Jm!zXyB4w',
          Microservice.wallet: 'eco-keypFvQnUOko=r4/G!chia5Fe2-6OU?2YNYqAPWlaiN!uYrZIdwoUNv9P4d7',
        },
      ),
    );
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
