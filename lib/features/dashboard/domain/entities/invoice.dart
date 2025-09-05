import 'package:my_app/core/data/dtos/invoice_dto.dart';
import 'package:my_app/features/dashboard/domain/entities/invoice_detail.dart';

enum InvoiceStatus { activa, inactiva }

class Invoice {
  final int id;
  final DateTime? createdAt;
  final InvoiceStatus status;
  final double totalInvoice;
  final String paymentMethod;
  final List<InvoiceDetail> details;

  Invoice({
    required this.id,
    required this.createdAt,
    required this.status,
    required this.totalInvoice,
    required this.paymentMethod,
    this.details = const [],
  });

  factory Invoice.fromDto(InvoiceDto dto) {
    return Invoice(
      id: dto.id,
      createdAt: dto.createdAt,
      status: dto.status == true ? InvoiceStatus.activa : InvoiceStatus.inactiva,
      totalInvoice: dto.totalInvoice ?? 0.0,
      paymentMethod: dto.paymentMethod ?? 'N/A',
      details: dto.invoicesDetails.map((detailDto) => InvoiceDetail.fromDto(detailDto)).toList(),
    );
  }
}
