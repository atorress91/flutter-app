import '../domain/entities/support_ticket.dart';

class SupportTicketData {
  static List<SupportTicket> getSampleTickets() {
    return [
      SupportTicket(
        id: 'TKT-001',
        message: 'No puedo acceder a mi billetera, me da un error inesperado.',
        category: 'Problema Técnico',
        status: TicketStatus.abierto,
        date: DateTime(2025, 8, 28),
      ),
      SupportTicket(
        id: 'TKT-002',
        message: 'Tengo una consulta sobre cómo registrar un nuevo cliente.',
        category: 'Consulta General',
        status: TicketStatus.enProceso,
        date: DateTime(2025, 8, 27),
      ),
      SupportTicket(
        id: 'TKT-003',
        message: 'El reporte de ventas del mes pasado no carga correctamente.',
        category: 'Reportes',
        status: TicketStatus.cerrado,
        date: DateTime(2025, 8, 25),
      ),
    ];
  }
}