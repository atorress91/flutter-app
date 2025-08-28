import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/features/dashboard/data/support_ticket_data.dart';
import 'package:my_app/features/dashboard/domain/entities/support_ticket.dart';
import '../widgets/customer_service/ticket_card.dart';

class CustomerServiceScreen extends StatefulWidget {
  const CustomerServiceScreen({super.key});

  @override
  State<CustomerServiceScreen> createState() => _CustomerServiceScreenState();
}

class _CustomerServiceScreenState extends State<CustomerServiceScreen> {
  late List<SupportTicket> _tickets;

  @override
  void initState() {
    super.initState();
    _tickets = SupportTicketData.getSampleTickets();
  }

  void _deleteTicket(String id) {
    setState(() {
      _tickets.removeWhere((ticket) => ticket.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ticket eliminado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Servicio al Cliente',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: () {
                      // Lógica para crear un nuevo ticket
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Crear Ticket'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: _tickets.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final ticket = _tickets[index];
                  return TicketCard(
                    ticket: ticket,
                    onDelete: () => _deleteTicket(ticket.id),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}