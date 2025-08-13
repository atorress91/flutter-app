import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../domain/entities/transaction.dart';
import '../data/wallet_data.dart';
import '../widgets/wallet/transaction_history_list.dart';
import '../widgets/wallet/wallet_summary_card.dart';

class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen({super.key});

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  bool _isLoading = false;
  List<Transaction> _transactions = [];

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
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        _transactions = WalletData.getSampleTransactions();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    final formatCurrency = NumberFormat.currency(
      locale: 'en_US',
      symbol: 'USD ',
    );

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
                      'Mi Billetera',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // --- SECCIÓN DE RESUMEN ---
                    SizedBox(
                      height: 160,
                      child: Row(
                        children: [
                          Expanded(
                            child: WalletSummaryCard(
                              icon: Icons.account_balance_wallet_outlined,
                              title: 'Saldo Disponible',
                              value: formatCurrency.format(78.59),
                              color: Colors.blue.shade600,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: WalletSummaryCard(
                              icon: Icons.trending_up_rounded,
                              title: 'Saldo Ganado',
                              value: formatCurrency.format(940.59),
                              color: Colors.green.shade600,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: WalletSummaryCard(
                              icon: Icons.star_border_rounded,
                              title: 'Tokens Bonos',
                              value: '90',
                              color: Colors.purple.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // --- SECCIÓN DE MOVIMIENTOS ---
                    Text(
                      'Movimientos Recientes',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TransactionHistoryList(transactions: _transactions),
                  ],
                ),
        ),
      ),
    );
  }
}
