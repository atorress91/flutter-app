import 'package:my_app/features/dashboard/domain/entities/invoice.dart';
import 'package:my_app/features/dashboard/domain/entities/purchase.dart';
import 'package:my_app/features/dashboard/domain/entities/purchase_status.dart';

class InvoiceMapper {
  static Purchase toPurchase(Invoice invoice) {
    return Purchase(
      noFa: invoice.id.toString(),
      fecha: invoice.createdAt ?? DateTime.now(),
      modelo: invoice.details.isNotEmpty ? invoice.details.first.productName : 'N/A',
      detalle: 'Compra de productos',
      monto: invoice.totalInvoice,
      status: invoice.status == InvoiceStatus.activa ? PurchaseStatus.completado : PurchaseStatus.devuelto,
    );
  }
}