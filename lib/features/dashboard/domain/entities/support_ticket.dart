enum TicketStatus { abierto, enProceso, cerrado }

class SupportTicket {
  final String id;
  final String message;
  final String category;
  final TicketStatus status;
  final DateTime date;

  SupportTicket({
    required this.id,
    required this.message,
    required this.category,
    required this.status,
    required this.date,
  });
}
