import 'package:flutter/material.dart';
import 'package:my_app/features/dashboard/widgets/stats_carousel/stat_card.dart';

class BalanceInfo extends StatelessWidget {
  const BalanceInfo({super.key});

  @override
  Widget build(BuildContext context) {
    // Aquí definimos los datos de los balances
    final balanceData = [
      {
        'title': 'Saldo Disponible',
        'value': 'USD \$78.59',
        'icon': Icons.account_balance_wallet_outlined,
        'color': Colors.green,
      },
      {
        'title': 'Total Pagado',
        'value': 'USD \$940.59',
        'icon': Icons.receipt_long_outlined,
        'color': Colors.blue,
      },
      {
        'title': 'Mis Recycoins',
        'value': 'USD \$385',
        'icon': Icons.monetization_on_outlined,
        'color': Colors.orange,
      }
    ];

    // Usamos Wrap para que se ajuste automáticamente en diferentes tamaños de pantalla
    return Wrap(
      spacing: 16.0, // Espacio horizontal entre tarjetas
      runSpacing: 16.0, // Espacio vertical si se van a una nueva línea
      children: balanceData.map((data) {
        return StatCard(
          title: data['title'] as String,
          value: data['value'] as String,
          icon: data['icon'] as IconData,
          color: data['color'] as Color,
        );
      }).toList(),
    );
  }
}