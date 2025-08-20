import 'package:my_app/core/data/dtos/balance_information_dto.dart';
import 'package:my_app/features/dashboard/domain/entities/balance_information.dart';

class BalanceInformationMapper {
  static BalanceInformation fromDto(BalanceInformationDto dto) {
    return BalanceInformation(
      reverseBalance: dto.reverseBalance,
      totalAcquisitions: dto.totalAcquisitions,
      availableBalance: dto.availableBalance,
      totalCommissionsPaid: dto.totalCommissionsPaid,
      serviceBalance: dto.serviceBalance,
      bonusAmount: dto.bonusAmount,
    );
  }
}
