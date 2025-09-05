import 'package:my_app/features/dashboard/domain/entities/invoice.dart';
import 'package:my_app/features/dashboard/domain/entities/purchase.dart';
import 'package:my_app/features/dashboard/domain/entities/purchase_status.dart';

class InvoiceMapper {
  static Purchase toPurchase(Invoice invoice) {
    return Purchase(
      invoiceNo: invoice.id.toString(),
      date: invoice.createdAt ?? DateTime.now(),
      model: invoice.details.isNotEmpty ? invoice.details.first.productName : 'N/A',
      details: invoice.paymentMethod,
      amount: invoice.totalInvoice,
      status: invoice.status == InvoiceStatus.activa ? PurchaseStatus.completado : PurchaseStatus.devuelto,
    );
  }
}