import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/core/common/widgets/custom_loading_indicator.dart';
import 'package:my_app/core/common/widgets/custom_refresh_indicator.dart';
import 'package:my_app/features/dashboard/presentation/controllers/request_payment_screen_controller.dart';
import 'package:my_app/core/l10n/app_localizations.dart';

import 'package:my_app/features/dashboard/presentation/widgets/request_payment/new_payment_request_modal.dart';
import 'package:my_app/features/dashboard/presentation/widgets/request_payment/payment_history_list.dart';
import 'package:my_app/features/dashboard/presentation/widgets/request_payment/payment_info_card.dart';

class RequestPaymentScreen extends ConsumerStatefulWidget {
  const RequestPaymentScreen({super.key});

  @override
  ConsumerState<RequestPaymentScreen> createState() => _RequestPaymentScreenState();
}

class _RequestPaymentScreenState extends ConsumerState<RequestPaymentScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(requestPaymentControllerProvider.notifier).loadConfiguration();
      ref.read(requestPaymentControllerProvider.notifier).getWalletRequests();
      ref.read(requestPaymentControllerProvider.notifier).checkWithdrawalLimit();
    });
  }

  Future<void> _handleRefresh() async {
    await ref.read(requestPaymentControllerProvider.notifier).loadConfiguration();
    await ref.read(requestPaymentControllerProvider.notifier).checkWithdrawalLimit();
    await ref.read(requestPaymentControllerProvider.notifier).getWalletRequests();
  }

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
    final requestPaymentState = ref.watch(requestPaymentControllerProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomRefreshIndicator(
          onRefresh: _handleRefresh,
          child: requestPaymentState.isLoading && requestPaymentState.configuration == null
              ? const Center(child: CustomLoadingIndicator())
              : CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          Text(
                            AppLocalizations.of(context).requestPaymentTitle,
                            style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 24),
                          PaymentInfoCard(
                            availableBalance: 78.59,
                            minimumAmount: requestPaymentState.configuration?.minimumAmount.toDouble() ?? 0.0,
                          ),
                          const SizedBox(height: 32),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.payments_outlined,
                                size: 28,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  AppLocalizations.of(context).requestPaymentHistoryTitle,
                                  style: textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (!requestPaymentState.hasReachedWithdrawalLimit)
                                Tooltip(
                                  message: AppLocalizations.of(context).requestPaymentNewRequestButton,
                                  child: IconButton(
                                    onPressed: () => _openRequestModal(context),
                                    icon: Icon(
                                      Icons.add_circle_rounded,
                                      size: 30,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ]),
                      ),
                    ),
                    // Lista virtualizada de historial
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      sliver: PaymentHistorySliverList(requests: requestPaymentState.requests),
                    ),
                    // Espacio final para evitar que el último item quede demasiado pegado al borde inferior
                    const SliverToBoxAdapter(child: SizedBox(height: 32)),
                  ],
                ),
        ),
      ),
    );
  }
}