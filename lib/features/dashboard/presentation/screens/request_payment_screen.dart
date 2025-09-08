import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/core/common/widgets/custom_refresh_indicator.dart';
import 'package:my_app/features/dashboard/data/payment_request_data.dart';
import 'package:my_app/features/dashboard/domain/entities/payment_request.dart';
import 'package:my_app/features/dashboard/presentation/widgets/request_payment/new_payment_request_modal.dart';
import 'package:my_app/features/dashboard/presentation/widgets/request_payment/payment_history_list.dart';
import 'package:my_app/features/dashboard/presentation/widgets/request_payment/payment_info_card.dart';

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
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: const SingleChildScrollView(child: NewPaymentRequestModal()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomRefreshIndicator(
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
