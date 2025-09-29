import 'package:my_app/core/data/dtos/wallet_request_dto.dart';
import 'package:my_app/features/dashboard/domain/entities/payment.dart';

class RequestMapper {
  static Payment fromDto(WalletRequestDto dto) {
    return Payment(
      amount: dto.amount,
      observation: dto.concept ?? 'N/A',
      adminResponse: dto.adminUserName ?? 'N/A',
      status: dto.status == 1 ? RequestStatus.aprobado : RequestStatus.rechazado,
      type: dto.type ?? 'N/A',
      date: dto.createdAt,
    );
  }
}
