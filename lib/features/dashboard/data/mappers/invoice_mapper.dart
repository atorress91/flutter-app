import 'package:my_app/core/data/dtos/invoice_dto.dart';
import 'package:my_app/features/dashboard/data/mappers/invoice_detail_mapper.dart';
import 'package:my_app/features/dashboard/domain/entities/purchase.dart';
import 'package:my_app/features/dashboard/domain/entities/purchase_status.dart';

class InvoiceMapper {
  static Purchase fromDto(InvoiceDto invoice) {
    return Purchase(
      invoiceNo: invoice.id.toString(),
      createdAt: invoice.createdAt ?? DateTime.now(),
      details: InvoiceDetailMapper.fromDtoList(invoice.invoicesDetails),
      amount: invoice.totalInvoice ?? 0.0,
      status: invoice.status == true ? PurchaseStatus.completado : PurchaseStatus.devuelto,
      paymentMethod: invoice.paymentMethod ?? 'No especificado',
    );
  }
}