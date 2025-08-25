import 'package:equatable/equatable.dart';

class NetworkPurchase extends Equatable {
  final int year;
  final int month;
  final int totalPurchases;

  const NetworkPurchase({
    required this.year,
    required this.month,
    required this.totalPurchases,
  });

  @override
  List<Object?> get props => [year, month, totalPurchases];
}
