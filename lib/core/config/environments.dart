enum AppEnvironment { local, prod }

enum Microservice { account, systemConfiguration, inventory, wallet }

class EnvironmentConfig {
  final Map<Microservice, String> endpoints;
  final Map<Microservice, String> serviceKeys;
  final String clientId;

  const EnvironmentConfig({
    required this.endpoints,
    required this.clientId,
    this.serviceKeys = const {},
  });
}

/// Singleton-like environment holder
class Environment {
  static AppEnvironment _env = AppEnvironment.local;

  static final Map<AppEnvironment, Map<Microservice, String>> _baseUrls = {
    AppEnvironment.local: {
      Microservice.account: 'https://account.recycoin.net',
      Microservice.systemConfiguration: 'https://configuration.recycoin.net',
      Microservice.inventory: 'http://localhost:3002',
      Microservice.wallet: 'https://wallet.recycoin.net',
    },
    AppEnvironment.prod: {
      Microservice.account: 'https://account.recycoin.net',
      Microservice.systemConfiguration: 'https://configuration.recycoin.net',
      Microservice.inventory: 'https://inventory.recycoin.net',
      Microservice.wallet: 'https://wallet.recycoin.net',
    },
  };

  static final Map<Microservice, String> _serviceKeys = {
    Microservice.account:
        'eco-keygJ-MrM8y9jUD/b1dN24=neYjxeUA=N-f?9sHuDCcJ0JWfx-ajo7yjVn441',
    Microservice.systemConfiguration:
        'eco-key8ZgMhRytu-Jrv1FU1rZSw2jM-FaBP!ou!sJNBITT3tA63GBrrQiVe3zvS',
    Microservice.inventory:
        'eco-keyLd5DU5faBWLfLrE1ATUK0c1qpvSci1x5TvFkDVw3FEM7JO30Jm!zXyB4w',
    Microservice.wallet:
        'eco-keypFvQnUOko=r4/G!chia5Fe2-6OU?2YNYqAPWlaiN!uYrZIdwoUNv9P4d7',
  };

  static const String _clientId = 'eco-keyhFvQoUOk=r6/F!chia2Fe1-8OU?4YNWqAVWlaiN!tYrWIdvoUMv8Q6d6';

  static void set(AppEnvironment env) {
    _env = env;
  }

  static void configureLocal() {
    set(AppEnvironment.local);
  }

  static void configureProduction() {
    set(AppEnvironment.prod);
  }

  static AppEnvironment get current => _env;

  static EnvironmentConfig get config {
    final urls = _baseUrls[_env]!;
    return EnvironmentConfig(
      endpoints: urls.map((service, url) => MapEntry(service, '$url/api/v1')),
      clientId: _clientId,
      serviceKeys: _serviceKeys,
    );
  }

  static String baseUrlFor(Microservice service) =>
      config.endpoints[service] ?? '';

  static String get clientId => config.clientId;

  static String? serviceKeyFor(Microservice service) =>
      config.serviceKeys[service];
}
