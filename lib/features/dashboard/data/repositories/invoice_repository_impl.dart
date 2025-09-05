import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/core/services/api/invoice_service.dart';

import 'package:my_app/features/dashboard/domain/entities/invoice.dart';
import 'package:my_app/features/dashboard/domain/repositories/invoice_repository.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  final InvoiceService _invoiceService;

  InvoiceRepositoryImpl(this._invoiceService);

  @override
  Future<List<Invoice>> getAllInvoicesByUserId(int userId) async {
    final response = await _invoiceService.getAllInvoicesByUserId(userId);

    if (response.success && response.data != null) {
      return response.data!.map((dto) => Invoice.fromDto(dto)).toList();
    } else {
      throw ApiException(
        response.message ?? 'Error al obtener las facturas del usuario',
      );
    }
  }
}
