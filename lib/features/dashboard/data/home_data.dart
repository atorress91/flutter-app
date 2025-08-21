import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:my_app/core/utils/currency_utils.dart';
import 'package:my_app/features/dashboard/domain/entities/balance_information.dart';

class HomeData {
  static List<Map<String, dynamic>> getStatsData(BalanceInformation balance) {
    return [
      {
        'titleKey': 'statsRecycoinTotal',
        'value': CurrencyUtils.formatWithoutDecimals(
          (balance.totalAcquisitions + balance.bonusAmount),
        ),
        'icon': Icons.toll_outlined,
        'color': const Color(0xFF00F5D4),
      },
      {
        'titleKey': 'statsBonusTokens',
        'value': CurrencyUtils.formatWithoutDecimals(balance.bonusAmount),
        'icon': Icons.token_outlined,
        'color': const Color(0xFF00A8E8),
      },
      {
        'titleKey': 'statsMonthlyCommission',
        'value': '\$0',
        'icon': Icons.calendar_month,
        'color': const Color(0xFFFF5733),
      },
      {
        'titleKey': 'statsReferrals',
        'value': '\$0',
        'icon': Icons.group_add,
        'color': const Color(0xFF9B5DE5),
      },
    ];
  }

  static List<FlSpot> getPerformanceData() {
    return const [
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
    ];
  }

  // Nuevos métodos para datos de compras por año
  static List<FlSpot> getPurchaseDataYear1() {
    // Datos de compras para el primer año (enero a diciembre)
    return const [
      FlSpot(0, 1200),  // Enero
      FlSpot(1, 1500),  // Febrero
      FlSpot(2, 1100),  // Marzo
      FlSpot(3, 1800),  // Abril
      FlSpot(4, 1400),  // Mayo
      FlSpot(5, 2000),  // Junio
      FlSpot(6, 2200),  // Julio
      FlSpot(7, 1900),  // Agosto
      FlSpot(8, 2500),  // Septiembre
      FlSpot(9, 2100),  // Octubre
      FlSpot(10, 2800), // Noviembre
      FlSpot(11, 3000), // Diciembre
    ];
  }

  static List<FlSpot> getPurchaseDataYear2() {
    // Datos de compras para el segundo año (enero a diciembre)
    return const [
      FlSpot(0, 1400),  // Enero
      FlSpot(1, 1700),  // Febrero
      FlSpot(2, 1300),  // Marzo
      FlSpot(3, 2000),  // Abril
      FlSpot(4, 1600),  // Mayo
      FlSpot(5, 2200),  // Junio
      FlSpot(6, 2400),  // Julio
      FlSpot(7, 2100),  // Agosto
      FlSpot(8, 2700),  // Septiembre
      FlSpot(9, 2300),  // Octubre
      FlSpot(10, 3000), // Noviembre
      FlSpot(11, 3200), // Diciembre
    ];
  }

  static List<Map<String, dynamic>> getQuickActionsData() {
    return [
      {
        'icon': Icons.add_box,
        'labelKey': 'quickCreate',
        'color': const Color(0xFF9B5DE5),
      },
      {
        'icon': Icons.analytics,
        'labelKey': 'quickReports',
        'color': const Color(0xFF00A8E8),
      },
      {
        'icon': Icons.receipt_long,
        'labelKey': 'quickInvoices',
        'color': const Color(0xFFF15BB5),
      },
      {
        'icon': Icons.settings,
        'labelKey': 'quickSettings',
        'color': const Color(0xFF00F5D4),
      },
    ];
  }

  static List<Map<String, dynamic>> getRecentActivitiesData() {
    return [
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
  }
}
