import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:my_app/features/dashboard/domain/entities/network_purchase.dart';

class PerformanceChart extends StatelessWidget {
  final List<NetworkPurchase> purchases;

  const PerformanceChart({super.key, required this.purchases});

  @override
  Widget build(BuildContext context) {
    if (purchases.isEmpty) {
      return const SizedBox.shrink();
    }

    final currentYear = DateTime.now().year;
    final previousYear = currentYear - 1;

    final purchaseDataCurrentYear = purchases
        .where((p) => p.year == currentYear)
        .map((p) => FlSpot(p.month.toDouble() - 1, p.totalPurchases.toDouble()))
        .toList();

    final purchaseDataPreviousYear = purchases
        .where((p) => p.year == previousYear)
        .map((p) => FlSpot(p.month.toDouble() - 1, p.totalPurchases.toDouble()))
        .toList();

    return Column(
      children: [
        SizedBox(
          height: 180,
          child: Padding(
            padding: const EdgeInsets.only(right: 24.0, left: 12.0),
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const months = [
                          'Ene',
                          'Feb',
                          'Mar',
                          'Abr',
                          'May',
                          'Jun',
                          'Jul',
                          'Ago',
                          'Sep',
                          'Oct',
                          'Nov',
                          'Dic',
                        ];
                        if (value.toInt() >= 0 &&
                            value.toInt() < months.length) {
                          return Text(
                            months[value.toInt()],
                            style: const TextStyle(fontSize: 12),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: purchaseDataPreviousYear,
                    isCurved: true,
                    color: const Color(0xFF00F5D4),
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  ),
                  LineChartBarData(
                    spots: purchaseDataCurrentYear,
                    isCurved: true,
                    color: const Color(0xFF00A8E8),
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem(previousYear.toString(), const Color(0xFF00F5D4)),
              const SizedBox(width: 24),
              _buildLegendItem(currentYear.toString(), const Color(0xFF00A8E8)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 3,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}