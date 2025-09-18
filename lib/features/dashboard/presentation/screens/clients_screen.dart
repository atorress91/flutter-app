import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/core/common/widgets/custom_loading_indicator.dart';
import 'package:my_app/core/common/widgets/custom_refresh_indicator.dart';
import 'package:my_app/core/common/widgets/info_card.dart';
import 'package:my_app/features/dashboard/domain/entities/client.dart';

import 'package:my_app/features/dashboard/presentation/controllers/clients_screen_controller.dart';
import 'package:my_app/features/dashboard/presentation/widgets/clients/optimized_genealogy_view.dart';
import 'package:my_app/features/dashboard/presentation/widgets/clients/vertical_tree_view.dart';

class ClientsScreen extends ConsumerStatefulWidget {
  const ClientsScreen({super.key});

  @override
  ConsumerState<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends ConsumerState<ClientsScreen> {
  bool _genealogyView = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          ref.read(clientsScreenControllerProvider.notifier).loadUnilevelTree(),
    );
  }

  Future<void> _handleRefresh() async {
    await ref.read(clientsScreenControllerProvider.notifier).refresh();
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
    final clientsState = ref.watch(clientsScreenControllerProvider);
    final uniLevelTree = clientsState.uniLevelTree;

    final directClients = uniLevelTree?.referrals ?? [];
    final int indirectClientsCount = _countIndirectClients(directClients);
    final int totalClients = directClients.length + indirectClientsCount;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomRefreshIndicator(
          onRefresh: _handleRefresh,
          child: clientsState.isLoading && uniLevelTree == null
              ? const Center(child: CustomLoadingIndicator())
              : SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        child: SizedBox(
                          height: 90,
                          child: Row(
                            children: [
                              Expanded(
                                child: InfoCard(
                                  icon: Icons.person_outline,
                                  title: 'Clientes Directos',
                                  value: directClients.length.toString(),
                                  color: const Color(0xFF00A8E8),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: InfoCard(
                                  icon: Icons.groups_outlined,
                                  title: 'Clientes Indirectos',
                                  value: indirectClientsCount.toString(),
                                  color: const Color(0xFF9B5DE5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          _genealogyView
                              ? 'UniLevel ($totalClients en total)'
                              : 'UniLevel ($totalClients en total)',
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildTreeContent(directClients),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildTreeContent(List<Client> directClients) {
    if (directClients.isEmpty) {
      return const Center(child: Text('Aún no tienes clientes directos.'));
    }

    if (_genealogyView) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: OptimizedGenealogyView(
          rootTitle: 'Mi Red',
          directClients: directClients,
        ),
      );
    } else {
      return VerticalTreeView(directClients: directClients);
    }
  }
}
