import 'package:equatable/equatable.dart';

class InvoiceDetail extends Equatable{
  final String productName;
  final int productQuantity;

  const InvoiceDetail({
    required this.productName,
    required this.productQuantity
  });

  @override
  List<Object?> get props => [
    productName,
    productQuantity
  ];
}
