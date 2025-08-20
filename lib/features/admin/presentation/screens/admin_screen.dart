import 'package:flutter/material.dart';
import 'package:my_app/features/admin/presentation/widgets/admin_navbar.dart';
import 'package:my_app/features/admin/presentation/widgets/admin_sidebar.dart';

class AdminScreen extends StatelessWidget {
  final Widget child;

  const AdminScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AdminNavbar(), // Navbar específico para admin
      drawer: const AdminSidebar(), // Sidebar específico para admin
      body: child, // Contenido principal ocupa todo el espacio disponible
    );
  }
}
