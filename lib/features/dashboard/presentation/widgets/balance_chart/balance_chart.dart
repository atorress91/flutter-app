import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_app/features/dashboard/presentation/models/balance_chart_view_model.dart';
import 'balance_chart_center.dart';
import 'balance_chart_legend.dart';
import 'balance_chart_section.dart';

class BalanceChart extends StatefulWidget {
  final BalanceChartViewModel viewModel;

  const BalanceChart({super.key, required this.viewModel});

  @override
  State<BalanceChart> createState() => _BalanceChartState();
}

class _BalanceChartState extends State<BalanceChart>
    with TickerProviderStateMixin {
  int touchedIndex = -1;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final balance = widget.viewModel.latestBalance;

    return Column(
      children: [
        SizedBox(
          height: 280,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Efecto de pulso al seleccionar
              if (touchedIndex != -1)
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    final color = getSectionData(touchedIndex, balance).color;
                    return Container(
                      width: 200 + (_pulseController.value * 20),
                      height: 200 + (_pulseController.value * 20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: color.withAlpha(
                              (255 * 0.3 * _pulseController.value).toInt(),
                            ),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (event, pieTouchResponse) {
                      if (event is FlTapUpEvent &&
                          pieTouchResponse?.touchedSection != null) {
                        setState(() {
                          final index = pieTouchResponse
                              ?.touchedSection!
                              .touchedSectionIndex;
                          touchedIndex = ((touchedIndex == index)
                              ? -1
                              : index)!;
                        });
                      }
                    },
                  ),
                  sectionsSpace: 4,
                  centerSpaceRadius: 75,
                  startDegreeOffset: -90,
                  sections: [
                    buildChartSection(
                      index: 0,
                      balance: balance,
                      touchedIndex: touchedIndex,
                    ),
                    buildChartSection(
                      index: 1,
                      balance: balance,
                      touchedIndex: touchedIndex,
                    ),
                    buildChartSection(
                      index: 2,
                      balance: balance,
                      touchedIndex: touchedIndex,
                    ),
                  ],
                ),
              ),
              BalanceChartCenter(
                touchedIndex: touchedIndex,
                viewModel: widget.viewModel,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        BalanceChartLegend(balance: balance),
      ],
    );
  }
}
