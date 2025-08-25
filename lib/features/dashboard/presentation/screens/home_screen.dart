import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import 'package:my_app/features/dashboard/data/providers/balance_providers.dart';
import 'package:my_app/features/dashboard/data/providers/network_purchase_providers.dart';
import 'package:my_app/features/dashboard/presentation/mappers/balance_chart_mapper.dart';
import 'package:my_app/features/dashboard/presentation/widgets/balance_chart/balance_chart.dart';
import '../../domain/entities/balance_state.dart';

import 'package:my_app/features/dashboard/presentation/widgets/contract_details.dart';
import 'package:my_app/features/dashboard/presentation/widgets/performance_chart.dart';
import 'package:my_app/features/dashboard/presentation/widgets/quick_actions/quick_actions.dart';
import 'package:my_app/features/dashboard/presentation/widgets/recent_activity.dart';
import 'package:my_app/features/dashboard/presentation/widgets/stats_carousel/stats_carousel.dart';
import 'package:my_app/features/dashboard/presentation/widgets/welcome_header.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(balanceControllerProvider.notifier).getBalanceInformation();
      ref.read(networkPurchaseControllerProvider.notifier).getNetworkPurchases();
    });
  }

  // El método _handleRefresh ahora puede re-llamar al controller.
  Future<void> _handleRefresh() async {
    await ref.read(balanceControllerProvider.notifier).getBalanceInformation();
    await ref.read(networkPurchaseControllerProvider.notifier).getNetworkPurchases();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    final balanceState = ref.watch(balanceControllerProvider);
    final networkPurchaseState = ref.watch(networkPurchaseControllerProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: Theme.of(context).colorScheme.primary,
          child: balanceState.isLoading && balanceState.balance == null
              ? const Center(child: CircularProgressIndicator())
              : AnimationLimiter(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 375),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(child: widget),
                        ),
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: WelcomeHeader(),
                          ),
                          const SizedBox(height: 30),
                          if (balanceState.balance != null)
                            StatsCarousel(balance: balanceState.balance!),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              "Balances Recycoin",
                              style: textTheme.titleLarge?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 28),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: _buildBalanceContent(balanceState),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              "Detalles del Contrato",
                              style: textTheme.titleLarge?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: ContractDetails(),
                          ),
                          const SizedBox(height: 30),
                          if (networkPurchaseState.purchases.isNotEmpty) ...[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Text(
                                AppLocalizations.of(
                                  context,
                                ).homeAnnualPerformance,
                                style: textTheme.titleLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            PerformanceChart(purchases: networkPurchaseState.purchases),
                            const SizedBox(height: 30),
                          ],
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              AppLocalizations.of(context).homeQuickActions,
                              style: textTheme.titleLarge?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: QuickActions(),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              AppLocalizations.of(context).homeRecentActivity,
                              style: textTheme.titleLarge?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: RecentActivity(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  // 9. Widget helper para renderizar el contenido del balance según el estado
  Widget _buildBalanceContent(BalanceState state) {
    // Si hay un error, lo mostramos
    if (state.error != null && state.balance == null) {
      return Center(
        child: Text(
          'Error al cargar el balance:\n${state.error}',
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      );
    }

    // Si tenemos datos mostramos el gráfico.
    if (state.balance != null) {
      final viewModel = BalanceChartMapper.fromEntity(state.balance!);
      return BalanceChart(viewModel: viewModel);
    }

    return const Center(heightFactor: 5, child: CircularProgressIndicator());
  }
}
