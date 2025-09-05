import 'package:my_app/features/dashboard/domain/entities/invoice.dart';

abstract class InvoiceRepository {
  Future<List<Invoice>> getAllInvoicesByUserId(int userId);
}