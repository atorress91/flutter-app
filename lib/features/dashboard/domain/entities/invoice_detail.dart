import 'package:my_app/core/data/dtos/invoice_detail_dto.dart';

class InvoiceDetail {
  final String productName;
  final int productQuantity;

  InvoiceDetail({
    required this.productName,
    required this.productQuantity
  });

  factory InvoiceDetail.fromDto(InvoiceDetailDto dto) {
    return InvoiceDetail(
      productName: dto.productName ?? 'N/A',
      productQuantity: dto.productQuantity,
    );
  }
}
