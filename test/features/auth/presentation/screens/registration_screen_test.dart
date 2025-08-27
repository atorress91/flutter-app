import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/features/auth/presentation/screens/registration_screen.dart';

void main() {
  group('RegistrationScreen', () {
    testWidgets('should render all form fields correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const RegistrationScreen(),
          ),
        ),
      );

      // Verificar que el título existe
      expect(find.text('Crear Cuenta'), findsOneWidget);

      // Verificar que todos los campos del formulario existen
      expect(find.text('Nombre de usuario'), findsOneWidget);
      expect(find.text('Contraseña'), findsOneWidget);
      expect(find.text('Confirmar contraseña'), findsOneWidget);
      expect(find.text('Nombre'), findsOneWidget);
      expect(find.text('Apellido'), findsOneWidget);
      expect(find.text('País'), findsOneWidget);
      expect(find.text('Número de teléfono'), findsOneWidget);
      expect(find.text('Correo electrónico'), findsOneWidget);
      expect(find.text('Usuario referidor (opcional)'), findsOneWidget);
      
      // Verificar checkbox de términos y condiciones
      expect(find.text('Acepto los términos y condiciones'), findsOneWidget);
      
      // Verificar botón de registro
      expect(find.text('Registrarse'), findsOneWidget);
      
      // Verificar link para ir al login
      expect(find.text('¿Ya tienes cuenta?'), findsOneWidget);
      expect(find.text('Iniciar Sesión'), findsOneWidget);
    });

    testWidgets('should show validation errors when form is invalid', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const RegistrationScreen(),
          ),
        ),
      );

      // Intentar enviar el formulario vacío
      await tester.tap(find.text('Registrarse'));
      await tester.pumpAndSettle();

      // Verificar que aparecen errores de validación
      expect(find.text('El nombre de usuario es requerido'), findsOneWidget);
      expect(find.text('La contraseña es requerida'), findsOneWidget);
      expect(find.text('Debes confirmar tu contraseña'), findsOneWidget);
      expect(find.text('El nombre es requerido'), findsOneWidget);
      expect(find.text('El apellido es requerido'), findsOneWidget);
      expect(find.text('El número de teléfono es requerido'), findsOneWidget);
      expect(find.text('El correo electrónico es requerido'), findsOneWidget);
    });

    testWidgets('should accept referral username parameter', (WidgetTester tester) async {
      const referralUserName = 'testuser123';
      
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const RegistrationScreen(referralUserName: referralUserName),
          ),
        ),
      );

      // Verificar que el campo de referido se prellenó
      final referralField = find.widgetWithText(TextFormField, 'Usuario referidor (opcional)');
      expect(referralField, findsOneWidget);
      
      // Verificar que el controlador tiene el valor correcto
      final textFormField = tester.widget<TextFormField>(referralField);
      expect(textFormField.controller?.text, equals(referralUserName));
    });
  });
}