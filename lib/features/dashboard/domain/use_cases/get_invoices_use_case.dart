import 'package:my_app/features/dashboard/domain/entities/invoice.dart';
import 'package:my_app/features/dashboard/domain/repositories/invoice_repository.dart';

class GetInvoicesUseCase {
  final InvoiceRepository _invoiceRepository;

  GetInvoicesUseCase(this._invoiceRepository);

  Future<List<Invoice>> execute({required int userId}) async {
    return await _invoiceRepository.getAllInvoicesByUserId(userId);
  }
}
