import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/payment_request_data.dart';
import '../domain/entities/payment_request.dart';
import '../widgets/request_payment/new_payment_request_modal.dart';
import '../widgets/request_payment/payment_history_list.dart';
import '../widgets/request_payment/payment_info_card.dart';

class RequestPaymentScreen extends StatefulWidget {
  const RequestPaymentScreen({super.key});

  @override
  State<RequestPaymentScreen> createState() => _RequestPaymentScreenState();
}

class _RequestPaymentScreenState extends State<RequestPaymentScreen> {
  bool _isLoading = false;
  List<PaymentRequest> _requests = [];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    setState(() => _isLoading = true);
    await _handleRefresh();
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleRefresh() async {
    // Simulación de llamada a API
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        _requests = PaymentRequestsData.getSampleRequests();
      });
    }
  }

  // --- NUEVA FUNCIÓN PARA ABRIR EL MODAL ---
  void _openRequestModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // Permite que el modal sea más alto que la mitad de la pantalla
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return const NewPaymentRequestModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  children: [
                    Text(
                      'Realizar solicitud de pago',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const PaymentInfoCard(
                      availableBalance: 78.59,
                      minimumAmount: 25.00,
                    ),
                    const SizedBox(height: 32),

                    // --- SECCIÓN DE ACCIÓN
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => _openRequestModal(context),
                        icon: const Icon(Icons.add),
                        label: const Text('Realizar Nueva Solicitud'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // --- SECCIÓN DE HISTORIAL ---
                    Text(
                      'Historial de Solicitudes',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    PaymentHistoryList(requests: _requests),
                  ],
                ),
        ),
      ),
    );
  }
}
