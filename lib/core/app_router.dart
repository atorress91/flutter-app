import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/features/admin/presentation/screens/admin_dashboard_screen.dart';
import 'package:my_app/features/admin/presentation/screens/admin_screen.dart';
import 'package:my_app/features/auth/presentation/screens/landing_screen.dart';
import 'package:my_app/features/auth/presentation/screens/login_screen.dart';
import 'package:my_app/features/auth/presentation/screens/registration_screen.dart';
import 'package:my_app/features/dashboard/presentation/screens/clients_screen.dart';
import 'package:my_app/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:my_app/features/dashboard/presentation/screens/home_screen.dart';
import 'package:my_app/features/dashboard/presentation/screens/my_wallet_screen.dart';
import 'package:my_app/features/dashboard/presentation/screens/purchases_screen.dart';
import 'package:my_app/features/dashboard/presentation/screens/request_payment_screen.dart';

// 1. GlobalKey para el ShellNavigator
// Esto nos permite mantener el estado del layout (navbar/sidebar) mientras cambiamos de pantalla.
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _dashboardShellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'dashboardShell');
final GlobalKey<NavigatorState> _adminShellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'adminShell');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/', // La app empieza en la pantalla de login
  routes: [
    // --- Rutas de Autenticación (sin layout) ---
    GoRoute(path: '/', builder: (context, state) => const LandingScreen()),
    GoRoute(
      path: '/auth/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/auth/register',
      builder: (context, state) => const RegistrationScreen(),
    ),

    // --- Rutas del Dashboard del Cliente (con layout) ---
    ShellRoute(
      navigatorKey: _dashboardShellNavigatorKey,
      builder: (context, state, child) {
        // El DashboardLayout envuelve todas las pantallas del cliente
        return DashboardScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'purchases', // <-- path relativo:
              builder: (context, state) => const PurchasesScreen(),
            ),
            GoRoute(
              path: 'clients',
              builder: (context, state) => const ClientsScreen(),
            ),
            GoRoute(
              path: 'request-payment',
              builder: (context, state) => const RequestPaymentScreen(),
            ),
            GoRoute(
              path: 'my-wallet',
              builder: (context, state) => const MyWalletScreen(),
            ),
          ],
        ),
        // más rutas del dashboard aquí
      ],
    ),

    // --- Rutas del Panel de Administración (con layout) ---
    ShellRoute(
      navigatorKey: _adminShellNavigatorKey,
      builder: (context, state, child) {
        // El AdminLayout envuelve todas las pantallas de admin
        return AdminScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/admin/dashboard',
          builder: (context, state) => const AdminDashboardScreen(),
        ),
        // más rutas de admin aquí
        // GoRoute(
        //   path: '/admin/users',
        //   builder: (context, state) => const UserManagementScreen(),
        // ),
      ],
    ),
  ],
  redirect: (context, state) {
    // lógica de autenticación
    // bool isLoggedIn = ...;
    // final bool isLoggingIn = state.matchedLocation == '/auth/login';
    // if (!isLoggedIn && !isLoggingIn) return '/auth/login';
    // if (isLoggedIn && isLoggingIn) return '/dashboard';

    return null; // No hay redirección por ahora
  },
);
