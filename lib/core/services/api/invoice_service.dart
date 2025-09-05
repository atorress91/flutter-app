import 'package:my_app/core/config/environments.dart';
import 'package:my_app/core/data/dtos/invoice_dto.dart';
import 'package:my_app/core/data/models/api_response.dart';
import 'package:my_app/core/services/api/base_service.dart';

class InvoiceService extends BaseService {
  InvoiceService({super.client}) : super(microservice: Microservice.wallet);

  Future<ApiResponse<List<InvoiceDto>?>> getAllInvoicesByUserId(
    int userId,
  ) async {
    return get<List<InvoiceDto>>(
      '/invoice/GetAllInvoicesByUserId/$userId',
      fromJson: (json) {
        if (json is List) {
          return json
              .map((e) => InvoiceDto.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return [];
      },
    );
  }
}
