import 'package:flutter/material.dart';
import 'package:my_app/core/config/environments.dart';
import 'main.dart' as app;

void main() {
  Environment.set(AppEnvironment.prod);
  // Optional: set your real production values here if different from defaults
  Environment.configure(prod: const EnvironmentConfig(baseUrl: 'https://api.tu-dominio.com', clientId: 'eco-keyhFvQoUOk=r6/F!chia2Fe1-8OU?4YNWqAVWlaiN!tYrWIdvoUMv8Q6d6'));
  runApp(const app.MyApp());
}
