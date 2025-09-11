import '../domain/entities/payment.dart';

class PaymentsData {
  static List<Payment> getSampleRequests() {
    return [
      Payment(
        amount: 10,
        observation: 'retiro recycoin',
        adminResponse: 'Atendido',
        status: RequestStatus.aprobado,
        type: 'Retiro de Saldo',
        date: DateTime(2025, 7, 28),
      ),
      Payment(
        amount: 100,
        observation: 'solicitud',
        adminResponse: 'Atendido',
        status: RequestStatus.aprobado,
        type: 'Retiro de Saldo',
        date: DateTime(2025, 7, 15),
      ),
      Payment(
        amount: 50,
        observation: 'Prueba pendiente',
        adminResponse: 'En revisión por el equipo.',
        status: RequestStatus.pendiente,
        type: 'Retiro de Saldo',
        date: DateTime(2025, 8, 10),
      ),
    ];
  }
}
