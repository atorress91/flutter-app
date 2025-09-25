import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/core/common/widgets/custom_loading_indicator.dart';
import 'package:my_app/core/common/widgets/custom_refresh_indicator.dart';
import 'package:my_app/core/common/widgets/info_card.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import 'package:my_app/features/dashboard/domain/entities/client.dart';

import 'package:my_app/features/dashboard/presentation/controllers/clients_screen_controller.dart';
import 'package:my_app/features/dashboard/presentation/widgets/clients/vertical_tree_view.dart';

class ClientsScreen extends ConsumerStatefulWidget {
  const ClientsScreen({super.key});

  @override
  ConsumerState<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends ConsumerState<ClientsScreen> {
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
                                AppLocalizations.of(context).t('clientsTitle'),
                                style: textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ),
                            Tooltip(
                              message: AppLocalizations.of(context).t('clientsAddClientTooltip'),
                              child: FilledButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.person_add_alt_1),
                                label: Text(AppLocalizations.of(context).t('clientsAddButton')),
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
                                  title: AppLocalizations.of(context).t('clientsDirect'),
                                  value: directClients.length.toString(),
                                  color: const Color(0xFF00A8E8),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: InfoCard(
                                  icon: Icons.groups_outlined,
                                  title: AppLocalizations.of(context).t('clientsIndirect'),
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
                          AppLocalizations.of(context).t('clientsUniLevel'),
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
      return Center(child: Text(AppLocalizations.of(context).t('clientsNoDirectClients')));
    }

    return VerticalTreeView(directClients: directClients);
  }
}
