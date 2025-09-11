import 'package:my_app/core/data/dtos/invoice_detail_dto.dart';
import 'package:my_app/features/dashboard/domain/entities/invoice_detail.dart';

class InvoiceDetailMapper {

  static InvoiceDetail fromDto(InvoiceDetailDto dto) {
    return InvoiceDetail(
      productName: dto.productName ?? 'Producto no disponible',
      productQuantity: dto.productQuantity,
    );
  }

  static List<InvoiceDetail> fromDtoList(List<InvoiceDetailDto> dtos) {
    return dtos.map((dto) => fromDto(dto)).toList();
  }
}