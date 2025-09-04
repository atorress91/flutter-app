import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_app/features/dashboard/presentation/controllers/my_wallet_screen_controller.dart';
import 'package:my_app/features/dashboard/presentation/states/my_wallet_state.dart';
import 'package:my_app/features/dashboard/presentation/widgets/wallet/filter_button.dart';
import 'package:my_app/features/dashboard/presentation/widgets/wallet/transaction_card.dart';
import 'package:my_app/features/dashboard/presentation/widgets/wallet/wallet_summary_card.dart';

class MyWalletScreen extends ConsumerStatefulWidget {
  const MyWalletScreen({super.key});

  @override
  ConsumerState<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends ConsumerState<MyWalletScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(myWalletControllerProvider.notifier).loadTransactions();
    });
  }

  Future<void> _handleRefresh() async {
    await ref.read(myWalletControllerProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    final colorScheme = Theme.of(context).colorScheme;
    final formatCurrency = NumberFormat.currency(locale: 'en_US', symbol: 'USD ');
    final walletState = ref.watch(myWalletControllerProvider);
    final walletController = ref.read(myWalletControllerProvider.notifier);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mi Billetera',
                      style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
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
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: 10.0,
                      children: [
                        FittedBox(
                          child: Text(
                            'Movimientos Recientes',
                            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHighest.withAlpha((255*0.3).toInt()),
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: colorScheme.outline.withAlpha((255*0.1).toInt()),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FilterButton(
                                icon: Icons.apps_rounded,
                                label: 'Todos',
                                isSelected: walletState.filter == TransactionFilterType.all,
                                onTap: () => walletController.setFilter(TransactionFilterType.all),
                                colorScheme: colorScheme,
                              ),
                              const SizedBox(width: 4),
                              FilterButton(
                                icon: Icons.add_circle_outline_rounded,
                                label: 'Ingresos',
                                isSelected: walletState.filter == TransactionFilterType.credit,
                                onTap: () => walletController.setFilter(TransactionFilterType.credit),
                                colorScheme: colorScheme,
                                selectedColor: Colors.green.shade600,
                              ),
                              const SizedBox(width: 4),
                              FilterButton(
                                icon: Icons.remove_circle_outline_rounded,
                                label: 'Gastos',
                                isSelected: walletState.filter == TransactionFilterType.debit,
                                onTap: () => walletController.setFilter(TransactionFilterType.debit),
                                colorScheme: colorScheme,
                                selectedColor: Colors.red.shade600,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: (walletState.isLoading && walletState.transactions.isEmpty)
                    ? const Center(child: CircularProgressIndicator())
                    : walletState.error != null
                    ? Center(child: Text(walletState.error!))
                    : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: walletState.filteredTransactions.length,
                  itemBuilder: (context, index) {
                    final transaction = walletState.filteredTransactions[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: TransactionCard(transaction: transaction),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}