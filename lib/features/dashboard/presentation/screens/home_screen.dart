import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:my_app/core/common/widgets/custom_loading_indicator.dart';
import 'package:my_app/core/common/widgets/custom_refresh_indicator.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import 'package:my_app/features/dashboard/presentation/controllers/home_screen_controller.dart';
import 'package:my_app/features/dashboard/presentation/mappers/balance_chart_mapper.dart';
import 'package:my_app/features/dashboard/presentation/states/home_state.dart';
import 'package:my_app/features/dashboard/presentation/widgets/balance_chart/balance_chart.dart';
import 'package:my_app/features/dashboard/presentation/widgets/contract_details.dart';
import 'package:my_app/features/dashboard/presentation/widgets/performance_chart.dart';
import 'package:my_app/features/dashboard/presentation/widgets/quick_actions/quick_actions.dart';
import 'package:my_app/features/dashboard/presentation/widgets/recent_activity/recent_activity.dart';
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
      ref.read(homeScreenControllerProvider.notifier).loadInitialData();
    });
  }

  Future<void> _handleRefresh() async {
    await ref.read(homeScreenControllerProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);

    // provider para todo el estado de la pantalla
    final homeState = ref.watch(homeScreenControllerProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomRefreshIndicator(
          onRefresh: _handleRefresh,
          child: homeState.isLoading && homeState.balance == null
              ? const Center(child: CustomLoadingIndicator())
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
                          // Usamos los datos del homeState
                          if (homeState.balance != null)
                            StatsCarousel(balance: homeState.balance!),
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
                            child: _buildBalanceContent(homeState),
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
                          // Usamos los datos del homeState
                          if (homeState.purchases.isNotEmpty) ...[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                              ),
                              child: Text(
                                AppLocalizations.of(
                                  context,
                                ).homeAnnualPerformance,
                                style: textTheme.titleLarge?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            PerformanceChart(purchases: homeState.purchases),
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

  // 4. El método helper ahora recibe el HomeState unificado
  Widget _buildBalanceContent(HomeState state) {
    if (state.error != null && state.balance == null) {
      return Center(
        child: Text(
          'Error al cargar el balance:\n${state.error}',
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      );
    }

    if (state.balance != null) {
      final viewModel = BalanceChartMapper.fromEntity(state.balance!);
      return BalanceChart(viewModel: viewModel);
    }

    // Muestra un loading si el balance aún no ha llegado pero la carga general sí empezó
    return const Center(heightFactor: 5, child: CustomLoadingIndicator());
  }
}
