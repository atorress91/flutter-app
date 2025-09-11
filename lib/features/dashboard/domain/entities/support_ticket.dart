import 'package:equatable/equatable.dart';

enum TicketStatus { abierto, enProceso, cerrado }

class SupportTicket extends Equatable {
  final String id;
  final String message;
  final String category;
  final TicketStatus status;
  final DateTime date;

  const SupportTicket({
    required this.id,
    required this.message,
    required this.category,
    required this.status,
    required this.date,
  });

  @override
  List<Object?> get props => [
    id,
    message,
    category,
    status,
    date
  ];
}
