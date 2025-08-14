import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BalancePoint {
  final DateTime date;
  final double available;
  final double locked;
  final double recycoins;

  const BalancePoint({
    required this.date,
    required this.available,
    required this.locked,
    this.recycoins = 0.0,
  });

  double get total => available + locked + recycoins;
}

class BalanceChart extends StatefulWidget {
  final List<BalancePoint> data;
  final String currencySymbol;

  const BalanceChart({
    super.key,
    required this.data,
    this.currencySymbol = '\$',
  });

  @override
  State<BalanceChart> createState() => _BalanceChartState();
}

class _BalanceChartState extends State<BalanceChart>
    with TickerProviderStateMixin {
  int touchedIndex = -1;
  AnimationController?
  _pulseController; // antes: late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }

  // Opcional pero útil en debug: asegura el controlador tras hot reload
  @override
  void reassemble() {
    super.reassemble();
    // Re-crear para que el pulso siga activo tras hot reload
    _pulseController?.dispose();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController?.dispose(); // antes: _pulseController.dispose();
    super.dispose();
  }

  String _getSectionLabel(int index) {
    switch (index) {
      case 0:
        return 'Saldo Disponible';
      case 1:
        return 'Saldo Bloqueado';
      case 2:
        return 'Mis Recycoins';
      default:
        return 'Total';
    }
  }

  String _getSectionDescription(int index) {
    switch (index) {
      case 0:
        return 'Disponible para retiro';
      case 1:
        return 'En proceso de liberación';
      case 2:
        return 'Recompensas ecológicas';
      default:
        return 'Balance total';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return const _EmptyState();
    }

    final theme = Theme.of(context);
    final latest = widget.data.last;
    final availableNow = latest.available;
    final lockedNow = latest.locked;
    final recycoinsNow = latest.recycoins;
    final totalNow = latest.total;

    // Colores diferenciados con tu color personalizado para Recycoins
    final colorAvailable = const Color(0xFF00F5D4); // Verde rico
    final colorLocked = const Color(0xFFE53935); // Rojo vibrante
    final colorRecoins = const Color.fromRGBO(
      197,
      252,
      68,
      1.0,
    ); // Tu color verde lima

    // Contenedor limpio sin shadow ni bordes
    return Column(
      children: [
        SizedBox(
          height: 280,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeOutCubic,
            builder: (context, t, _) {
              final shownAvailable = availableNow * t;
              final shownLocked = lockedNow * t;
              final shownRecoins = recycoinsNow * t;

              return Stack(
                alignment: Alignment.center,
                children: [
                  // Glow effect cuando se toca (protegido si el controller es null)
                  if (touchedIndex != -1 && _pulseController != null)
                    AnimatedBuilder(
                      animation: _pulseController!,
                      builder: (context, child) {
                        return Container(
                          width: 200 + (_pulseController!.value * 20),
                          height: 200 + (_pulseController!.value * 20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: _getSelectedColor(
                                  touchedIndex,
                                  colorAvailable,
                                  colorLocked,
                                  colorRecoins,
                                ).withOpacity(0.3 * _pulseController!.value),
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                  // dart
                  PieChart(
                    PieChartData(
                      startDegreeOffset: -90 + (1 - t) * 15,
                      sectionsSpace: 4,
                      centerSpaceRadius: 75,
                      pieTouchData: PieTouchData(
                        touchCallback: (event, response) {
                          // Mantener selección fija: solo actuamos en taps
                          if (response == null ||
                              response.touchedSection == null) {
                            return;
                          }

                          if (event is FlTapUpEvent) {
                            final idx =
                                response.touchedSection!.touchedSectionIndex;
                            if (mounted) {
                              setState(() {
                                // Toggle: si es la misma sección, deselecciona; si no, selecciona
                                touchedIndex = (touchedIndex == idx) ? -1 : idx;
                              });
                            }
                          }
                          // Ignoramos otros eventos para no limpiar la selección
                        },
                      ),
                      sections: _buildSections(
                        shownAvailable,
                        shownLocked,
                        shownRecoins,
                        colorAvailable,
                        colorLocked,
                        colorRecoins,
                        theme,
                      ),
                    ),
                  ),

                  // Contenido del centro mejorado
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    child: _CenterContent(
                      key: ValueKey<int>(touchedIndex),
                      value: _getCurrentValue(
                        touchedIndex,
                        shownAvailable,
                        shownLocked,
                        shownRecoins,
                        totalNow * t,
                      ),
                      symbol: widget.currencySymbol,
                      label: _getSectionLabel(touchedIndex),
                      description: _getSectionDescription(touchedIndex),
                      isSelected: touchedIndex != -1,
                      color: _getSelectedColor(
                        touchedIndex,
                        colorAvailable,
                        colorLocked,
                        colorRecoins,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        _buildLegend(theme, colorAvailable, colorLocked, colorRecoins, latest),
      ],
    );
  }

  Color _getSelectedColor(
    int index,
    Color available,
    Color locked,
    Color recoins,
  ) {
    switch (index) {
      case 0:
        return available;
      case 1:
        return locked;
      case 2:
        return recoins;
      default:
        return Colors.grey;
    }
  }

  double _getCurrentValue(
    int index,
    double available,
    double locked,
    double recoins,
    double total,
  ) {
    switch (index) {
      case 0:
        return available;
      case 1:
        return locked;
      case 2:
        return recoins;
      default:
        return total;
    }
  }

  List<PieChartSectionData> _buildSections(
    double available,
    double locked,
    double recoins,
    Color colorAvailable,
    Color colorLocked,
    Color colorRecoins,
    ThemeData theme,
  ) {
    return [
      _buildSection(
        index: 0,
        value: available,
        baseRadius: 65,
        color: colorAvailable,
        icon: Icons.account_balance_wallet_rounded,
        isTouched: touchedIndex == 0,
        theme: theme,
      ),
      _buildSection(
        index: 1,
        value: locked,
        baseRadius: 60,
        color: colorLocked,
        icon: Icons.lock_rounded,
        isTouched: touchedIndex == 1,
        theme: theme,
      ),
      _buildSection(
        index: 2,
        value: recoins,
        baseRadius: 55,
        color: colorRecoins,
        icon: Icons.eco_rounded,
        isTouched: touchedIndex == 2,
        theme: theme,
      ),
    ];
  }

  PieChartSectionData _buildSection({
    required int index,
    required double value,
    required double baseRadius,
    required Color color,
    required IconData icon,
    required bool isTouched,
    required ThemeData theme,
  }) {
    final radius = isTouched ? baseRadius + 12 : baseRadius;
    return PieChartSectionData(
      value: value <= 0 ? 0.001 : value,
      color: color.withOpacity(isTouched ? 1.0 : 0.85),
      radius: radius,
      title: '',
      showTitle: false,
      badgePositionPercentageOffset: 1.15,
      badgeWidget: _BadgeIcon(icon: icon, color: color, elevated: isTouched),
      borderSide: BorderSide(color: theme.scaffoldBackgroundColor, width: 2),
    );
  }

  Widget _buildLegend(
    ThemeData theme,
    Color colorAvailable,
    Color colorLocked,
    Color colorRecoins,
    BalancePoint latest,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _LegendItem(
          color: colorAvailable,
          label: 'Disponible',
          value: '${widget.currencySymbol}${_formatNumber(latest.available)}',
          icon: Icons.account_balance_wallet_rounded,
        ),
        _LegendItem(
          color: colorLocked,
          label: 'Bloqueado',
          value: '${widget.currencySymbol}${_formatNumber(latest.locked)}',
          icon: Icons.lock_rounded,
        ),
        _LegendItem(
          color: colorRecoins,
          label: 'Recycoins',
          value: '${_formatNumber(latest.recycoins, showSymbol: false)} RC',
          icon: Icons.eco_rounded,
        ),
      ],
    );
  }
}

class _CenterContent extends StatelessWidget {
  final double value;
  final String symbol;
  final String label;
  final String description;
  final bool isSelected;
  final Color color;

  const _CenterContent({
    super.key,
    required this.value,
    required this.symbol,
    required this.label,
    required this.description,
    required this.isSelected,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final valueText = label == 'Mis Recycoins'
        ? '${_formatNumber(value, showSymbol: false)} RC'
        : '$symbol${_formatNumber(value)}';

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            valueText,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: isSelected ? color : theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? color
                  : theme.colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
          if (isSelected) ...[
            const SizedBox(height: 2),
            Text(
              description,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                fontSize: 11,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final String value;
  final IconData icon;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _BadgeIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final bool elevated;

  const _BadgeIcon({
    required this.icon,
    required this.color,
    required this.elevated,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.all(elevated ? 10 : 8),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: color.withOpacity(0.3),
          width: elevated ? 3 : 2,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(elevated ? 0.4 : 0.2),
            blurRadius: elevated ? 15 : 8,
            spreadRadius: elevated ? 2 : 1,
          ),
        ],
      ),
      child: Icon(icon, size: elevated ? 18 : 16, color: color),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 280,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.pie_chart_outline_rounded,
            size: 48,
            color: theme.colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 12),
          Text(
            'Sin datos disponibles',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

String _formatNumber(double n, {bool compact = false, bool showSymbol = true}) {
  if (compact) return NumberFormat.compact(locale: 'es').format(n);
  return NumberFormat.currency(
    decimalDigits: n % 1 == 0 ? 0 : 2,
    symbol: showSymbol ? '' : '',
    locale: 'es',
  ).format(n);
}
