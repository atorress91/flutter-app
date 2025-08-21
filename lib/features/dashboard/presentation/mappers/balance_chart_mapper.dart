import 'package:my_app/features/dashboard/domain/entities/balance_information.dart';
import 'package:my_app/features/dashboard/presentation/models/balance_chart_view_model.dart';

/// Convierte la entidad de dominio [BalanceInformation] en un modelo
/// específico para la vista del gráfico de balance.
class BalanceChartMapper {
  static BalanceChartViewModel fromEntity(BalanceInformation entity) {
    return BalanceChartViewModel(
      latestBalance: BalancePoint(
        available: entity.availableBalance,
        locked: entity.totalCommissionsPaid,
        recycoins: entity.totalAcquisitions,
      ),

      currencySymbol: '\$',
    );
  }
}
