import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos el tema para consistencia de colores y fuentes
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        // Fondo con gradiente sutil para un look más profesional
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A2E),
              // Tu color primario
              const Color(0xFF2C2C4E).withAlpha((255 * 0.8).toInt()),
              // Tu color de tarjeta
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icono principal que representa tu app
                Icon(
                  Icons.dashboard_customize_rounded,
                  size: 80,
                  color: colorScheme.primary, // El color de acento (verde)
                ),
                const SizedBox(height: 24),

                // Título principal
                Text(
                  'Bienvenido a tu Dashboard',
                  textAlign: TextAlign.center,
                  style: textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),

                // Subtítulo o descripción
                Text(
                  'Gestiona tus datos y visualiza tu progreso de una manera fácil e intuitiva.',
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium?.copyWith(
                    color: Colors.white.withAlpha((255 * 0.7).toInt()),
                  ),
                ),
                const SizedBox(height: 48),

                // Botón de llamada a la acción (Call to Action)
                ElevatedButton(
                  onPressed: () {
                    // Navega a la pantalla de login al presionar
                    context.go('/auth/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary, // Color de acento
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Empezar ahora',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: const Color(0xFF1A1A2E), // Texto oscuro
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
