import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:my_app/core/l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos un tema de texto personalizado para consistencia
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: AnimationLimiter(
          child: SingleChildScrollView(
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
                  // Padding horizontal para el contenido principal
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: _WelcomeHeader(),
                  ),
                  const SizedBox(height: 30),

                  // tarjetas de estadísticas son un carrusel horizontal
                  _StatsCarousel(),
                  const SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      AppLocalizations.of(context).homeAnnualPerformance,
                      style: textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Gráfico de rendimiento profesional
                  const _PerformanceChart(),
                  const SizedBox(height: 30),

                  // Título para las acciones rápidas
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

                  // Accesos rápidos rediseñados
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: _QuickActions(),
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

                  // Actividad reciente
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: _RecentActivity(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- WIDGETS INTERNOS ---

class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).homeWelcomeBack,
              style: GoogleFonts.poppins(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withAlpha((255 * 0.7).toInt()),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'André',
              style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=andre'),
        ),
      ],
    );
  }
}

class _StatsCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stats = [
      {
        'titleKey': 'statsTotalSales',
        'value': '\$24,5k',
        'icon': Icons.trending_up,
        'color': const Color(0xFF00F5D4),
      },
      {
        'titleKey': 'statsActiveUsers',
        'value': '1,247',
        'icon': Icons.people,
        'color': const Color(0xFF00A8E8),
      },
      {
        'titleKey': 'statsNewOrders',
        'value': '218',
        'icon': Icons.shopping_cart,
        'color': const Color(0xFFFF5733),
      },
      {
        'titleKey': 'statsRevenue',
        'value': '\$18,7k',
        'icon': Icons.account_balance_wallet,
        'color': const Color(0xFF9B5DE5),
      },
    ];

    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: stats.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final stat = stats[index];
          return _StatCard(
            title: AppLocalizations.of(context).t(stat['titleKey'] as String),
            value: stat['value'] as String,
            icon: stat['icon'] as IconData,
            color: stat['color'] as Color,
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // 1. Usamos spaceBetween para separar los elementos verticalmente
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Elemento Superior
          CircleAvatar(
            backgroundColor: color.withAlpha((255 * 0.15).toInt()),
            radius: 20,
            child: Icon(icon, color: color, size: 20),
          ),

          // 2. Agrupamos los textos en su propia columna para mantenerlos juntos
          // El Spacer ya no es necesario
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withAlpha((255 * 0.7).toInt()),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PerformanceChart extends StatelessWidget {
  const _PerformanceChart();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Padding(
        padding: const EdgeInsets.only(right: 24.0, left: 12.0),
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: const [
                  FlSpot(0, 3),
                  FlSpot(1, 4),
                  FlSpot(2, 3.5),
                  FlSpot(3, 5),
                  FlSpot(4, 4),
                  FlSpot(5, 6),
                  FlSpot(6, 6.5),
                  FlSpot(7, 6),
                  FlSpot(8, 8),
                  FlSpot(9, 7),
                  FlSpot(10, 9),
                  FlSpot(11, 10),
                ],
                isCurved: true,
                color: const Color(0xFF00F5D4),
                barWidth: 4,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF00F5D4).withAlpha((255 * 0.3).toInt()),
                      const Color(0xFF00F5D4).withAlpha((255 * 0.0).toInt()),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _QuickActionButton(
          icon: Icons.add_box,
          label: AppLocalizations.of(context).quickCreate,
          color: const Color(0xFF9B5DE5),
        ),
        _QuickActionButton(
          icon: Icons.analytics,
          label: AppLocalizations.of(context).quickReports,
          color: const Color(0xFF00A8E8),
        ),
        _QuickActionButton(
          icon: Icons.receipt_long,
          label: AppLocalizations.of(context).quickInvoices,
          color: const Color(0xFFF15BB5),
        ),
        _QuickActionButton(
          icon: Icons.settings,
          label: AppLocalizations.of(context).quickSettings,
          color: const Color(0xFF00F5D4),
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withAlpha((255 * 0.8).toInt()),
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _RecentActivity extends StatelessWidget {
  const _RecentActivity();

  @override
  Widget build(BuildContext context) {
    final activities = [
      {
        'titleKey': 'activityNewSaleTitle',
        'subtitleKey': 'activityNewSaleSubtitle',
        'icon': Icons.shopping_cart_checkout,
        'color': const Color(0xFF00F5D4),
      },
      {
        'titleKey': 'activityUserRegisteredTitle',
        'subtitleKey': 'activityUserRegisteredSubtitle',
        'icon': Icons.person_add,
        'color': const Color(0xFF00A8E8),
      },
      {
        'titleKey': 'activityInventoryUpdatedTitle',
        'subtitleKey': 'activityInventoryUpdatedSubtitle',
        'icon': Icons.inventory_2,
        'color': const Color(0xFF9B5DE5),
      },
      {
        'titleKey': 'activityReportGeneratedTitle',
        'subtitleKey': 'activityReportGeneratedSubtitle',
        'icon': Icons.description,
        'color': const Color(0xFFF15BB5),
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        children: activities.map((activity) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: (activity['color'] as Color).withAlpha(
                    ((255 * 0.1.toInt())),
                  ),
                  child: Icon(
                    activity['icon'] as IconData,
                    color: activity['color'] as Color,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).t(activity['titleKey'] as String),
                        style: GoogleFonts.poppins(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context).t(activity['subtitleKey'] as String),
                        style: GoogleFonts.poppins(
                          color: Theme.of(context).colorScheme.onSurface
                              .withAlpha((255 * 0.6).toInt()),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withAlpha((255 * 0.24).toInt()),
                  size: 14,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
