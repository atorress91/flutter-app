import 'package:my_app/features/dashboard/domain/entities/purchase.dart';

abstract class InvoiceRepository {
  Future<List<Purchase>> getAllInvoicesByUserId(int userId);
}
