import '../domain/entities/payment_request.dart';

class PaymentRequestsData {
  static List<PaymentRequest> getSampleRequests() {
    return [
      PaymentRequest(
        amount: 10,
        observation: 'retiro recycoin',
        adminResponse: 'Atendido',
        status: RequestStatus.Aprobado,
        type: 'Retiro de Saldo',
        date: DateTime(2025, 7, 28),
      ),
      PaymentRequest(
        amount: 100,
        observation: 'solicitud',
        adminResponse: 'Atendido',
        status: RequestStatus.Aprobado,
        type: 'Retiro de Saldo',
        date: DateTime(2025, 7, 15),
      ),
      PaymentRequest(
        amount: 50,
        observation: 'Prueba pendiente',
        adminResponse: 'En revisión por el equipo.',
        status: RequestStatus.Pendiente,
        type: 'Retiro de Saldo',
        date: DateTime(2025, 8, 10),
      ),
    ];
  }
}
