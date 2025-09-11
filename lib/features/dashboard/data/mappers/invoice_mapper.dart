import 'package:my_app/core/data/dtos/invoice_dto.dart';
import 'package:my_app/features/dashboard/domain/entities/purchase.dart';
import 'package:my_app/features/dashboard/domain/entities/purchase_status.dart';

class InvoiceMapper {
  static Purchase fromDto(InvoiceDto invoice) {
    return Purchase(
      invoiceNo: invoice.id.toString(),
      date: invoice.createdAt ?? DateTime.now(),
      model: invoice.invoicesDetails.isNotEmpty ? invoice.invoicesDetails.first.productName ?? 'N/A' : 'N/A',
      details: invoice.paymentMethod ?? 'N/A',
      amount: invoice.totalInvoice ?? 0.0,
      status: invoice.status == true ? PurchaseStatus.completado : PurchaseStatus.devuelto,
    );
  }
}
