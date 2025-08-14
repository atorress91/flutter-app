import 'package:flutter/material.dart';
import 'package:my_app/core/config/environments.dart';
import 'main.dart' as app;

void main() {
  Environment.set(AppEnvironment.local);
  // Optional: override defaults if needed
  // Environment.configure(local: const EnvironmentConfig(baseUrl: 'http://10.0.2.2:3000', clientId: 'android-emulator'));
  runApp(const app.MyApp());
}
