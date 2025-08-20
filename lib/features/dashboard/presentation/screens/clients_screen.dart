import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/features/dashboard/domain/entities/client.dart';
import 'package:my_app/features/dashboard/presentation/widgets/clients/client_tree_node.dart';
import 'package:my_app/features/dashboard/presentation/widgets/clients/genealogy_tree/genealogy_tree_root.dart';
import 'package:my_app/features/dashboard/presentation/widgets/clients/summary_card.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  // --- NUEVO ESTADO PARA LA CARGA ---
  bool _isLoading = false;

  // --- DATOS DE EJEMPLO CON ESTRUCTURA DE ÁRBOL ---
  final List<Client> _directClients = [
    // ... (tus datos de clientes no cambian)
    Client(
      id: '001',
      name: 'Elena Rojas',
      avatarUrl: 'https://i.pravatar.cc/150?u=elena',
      joinDate: DateTime(2025, 1, 15),
      referrals: [
        Client(
          id: '101',
          name: 'Carlos Fallas',
          avatarUrl: 'https://i.pravatar.cc/150?u=carlos',
          joinDate: DateTime(2025, 2, 20),
          referrals: [
            Client(
              id: '201',
              name: 'Sofía Méndez',
              avatarUrl: 'https://i.pravatar.cc/150?u=sofia',
              joinDate: DateTime(2025, 3, 10),
            ),
          ],
        ),
        Client(
          id: '102',
          name: 'Luis Jiménez',
          avatarUrl: 'https://i.pravatar.cc/150?u=luis',
          joinDate: DateTime(2025, 2, 22),
        ),
      ],
    ),
    Client(
      id: '002',
      name: 'Mario Brenes',
      avatarUrl: 'https://i.pravatar.cc/150?u=mario',
      joinDate: DateTime(2025, 4, 5),
    ),
    Client(
      id: '003',
      name: 'Ana Vega',
      avatarUrl: 'https://i.pravatar.cc/150?u=ana',
      joinDate: DateTime(2025, 5, 1),
      referrals: [
        Client(
          id: '103',
          name: 'Pedro Soto',
          avatarUrl: 'https://i.pravatar.cc/150?u=pedro',
          joinDate: DateTime(2025, 6, 15),
        ),
      ],
    ),
  ];

  bool _genealogyView = false;

  // --- MÉTODOS DE MANEJO DE ESTADO ---
  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    setState(() => _isLoading = true);
    await _handleRefresh();
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleRefresh() async {
    // Simulación de 2 segundos de espera.
    await Future.delayed(const Duration(seconds: 2));

    // if (mounted) {
    //   setState(() {
    //     // Actualiza _directClients con los nuevos datos.
    //   });
    // }
  }

  int _countIndirectClients(List<Client> clients) {
    int count = 0;
    for (final client in clients) {
      count += client.referrals.length;
      count += _countIndirectClients(client.referrals);
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    final colorScheme = Theme.of(context).colorScheme;
    final int indirectClientsCount = _countIndirectClients(_directClients);
    final int totalClients = _directClients.length + indirectClientsCount;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- PARTE SUPERIOR ESTÁTICA (NO SE RECARGA) ---
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Mis Clientes',
                            style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                        Tooltip(
                          message: _genealogyView
                              ? 'Cambiar a árbol vertical'
                              : 'Cambiar a vista genealógica',
                          child: IconButton(
                            onPressed: () => setState(
                              () => _genealogyView = !_genealogyView,
                            ),
                            icon: Icon(
                              _genealogyView
                                  ? Icons.account_tree_outlined
                                  : Icons.family_restroom,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Tooltip(
                          message: 'Añadir Cliente',
                          child: FilledButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.person_add_alt_1),
                            label: const Text('Añadir'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: SummaryCard(
                            icon: Icons.person_outline,
                            title: 'Clientes Directos',
                            value: _directClients.length.toString(),
                            color: const Color(0xFF00A8E8),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SummaryCard(
                            icon: Icons.groups_outlined,
                            title: 'Clientes Indirectos',
                            value: indirectClientsCount.toString(),
                            color: const Color(0xFF9B5DE5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      _genealogyView
                          ? 'Árbol Genealógico ($totalClients en total)'
                          : 'Árbol de Referidos ($totalClients en total)',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // --- ÁREA DE SCROLL (ENVUELTA CON REFRESHINDICATOR) ---
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _handleRefresh,
                      child: _buildTreeContent(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  /// Widget helper que construye el contenido del árbol apropiado.
  Widget _buildTreeContent() {
    if (_directClients.isEmpty) {
      return const Center(child: Text('Aún no tienes clientes directos.'));
    }

    if (_genealogyView) {
      // Asumimos que GenealogyTreeRoot es un widget desplazable
      return GenealogyTreeRoot(title: 'Mis Clientes', children: _directClients);
    } else {
      return ListView.builder(
        // Se añade physics para asegurar que el scroll esté siempre activo
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _directClients.length,
        itemBuilder: (context, index) {
          return ClientTreeNode(client: _directClients[index]);
        },
      );
    }
  }
}
