import 'package:flutter/material.dart';
import 'package:my_app/core/config/environments.dart';
import 'main.dart' as app;

void main() {
  Environment.set(AppEnvironment.prod);
  // Definir endpoints de microservicios (URLs) y serviceKeys (Authorization) para producción
  Environment.configure(
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
  runApp(const app.MyApp());
}
