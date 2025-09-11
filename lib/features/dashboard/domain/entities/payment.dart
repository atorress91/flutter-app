import 'package:equatable/equatable.dart';

enum RequestStatus { aprobado, pendiente, rechazado }

class Payment extends Equatable {
  final double amount;
  final String observation;
  final String adminResponse;
  final RequestStatus status;
  final String type;
  final DateTime date;

  const Payment({
    required this.amount,
    required this.observation,
    required this.adminResponse,
    required this.status,
    required this.type,
    required this.date,
  });

  @override
  List<Object?> get props => [
    amount,
    observation,
    adminResponse,
    status,
    type,
    date,
  ];
}
