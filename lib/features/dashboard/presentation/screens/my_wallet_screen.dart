import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_app/core/common/widgets/custom_loading_indicator.dart';
import 'package:my_app/core/common/widgets/custom_refresh_indicator.dart';
import 'package:my_app/core/common/widgets/info_card.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import 'package:my_app/features/dashboard/presentation/controllers/my_wallet_screen_controller.dart';
import 'package:my_app/features/dashboard/presentation/states/my_wallet_state.dart';
import 'package:my_app/features/dashboard/presentation/widgets/wallet/filter_button.dart';
import 'package:my_app/features/dashboard/presentation/widgets/wallet/transaction_card.dart';

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
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomRefreshIndicator(
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
                      l10n.walletTitle,
                      style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 90,
                      child: Row(
                        children: [
                          Expanded(
                            child: InfoCard(
                              icon: Icons.account_balance_wallet_outlined,
                              title: l10n.walletAvailable,
                              value: formatCurrency.format(walletState.balance?.availableBalance ?? 0.0),
                              color: colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: InfoCard(
                              icon: Icons.trending_up_rounded,
                              title: l10n.walletEarned,
                              value: formatCurrency.format(walletState.balance?.totalCommissionsPaid ?? 0.0),
                              color: colorScheme.secondary,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: InfoCard(
                              icon: Icons.star_border_rounded,
                              title: l10n.walletTokens,
                              value: (walletState.balance?.bonusAmount ?? 0.0).toString(),
                              color: colorScheme.tertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(
                            l10n.walletRecentMovements,
                            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: colorScheme.surface.withAlpha((255*0.5).toInt()),
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                color: colorScheme.outline.withAlpha((255*0.5).toInt()),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FilterButton(
                                  icon: Icons.apps_rounded,
                                  label: l10n.walletFilterAll,
                                  isSelected: walletState.filter == TransactionFilterType.all,
                                  onTap: () => walletController.setFilter(TransactionFilterType.all),
                                ),
                                const SizedBox(width: 4),
                                FilterButton(
                                  icon: Icons.add_circle_outline_rounded,
                                  label: l10n.walletFilterIncome,
                                  isSelected: walletState.filter == TransactionFilterType.credit,
                                  onTap: () => walletController.setFilter(TransactionFilterType.credit),
                                  selectedColor: Colors.green.shade600,
                                ),
                                const SizedBox(width: 4),
                                FilterButton(
                                  icon: Icons.remove_circle_outline_rounded,
                                  label: l10n.walletFilterExpenses,
                                  isSelected: walletState.filter == TransactionFilterType.debit,
                                  onTap: () => walletController.setFilter(TransactionFilterType.debit),
                                  selectedColor: Colors.red.shade600,
                                ),
                              ],
                            ),
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
                    ? const Center(child: CustomLoadingIndicator())
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