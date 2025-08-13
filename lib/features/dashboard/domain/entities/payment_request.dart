enum RequestStatus { Aprobado, Pendiente, Rechazado }

class PaymentRequest {
  final double amount;
  final String observation;
  final String adminResponse;
  final RequestStatus status;
  final String type;
  final DateTime date;

  PaymentRequest({
    required this.amount,
    required this.observation,
    required this.adminResponse,
    required this.status,
    required this.type,
    required this.date,
  });
}