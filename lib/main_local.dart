import 'package:flutter/material.dart';
import 'package:my_app/core/config/environments.dart';
import 'main.dart' as app;

void main() {
  Environment.set(AppEnvironment.local);
  // Definir endpoints de microservicios (URLs) y serviceKeys (Authorization) para local
  Environment.configure(
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
  runApp(const app.MyApp());
}
