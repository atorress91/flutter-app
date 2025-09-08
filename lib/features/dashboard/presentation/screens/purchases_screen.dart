import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:my_app/core/common/widgets/custom_loading_indicator.dart';
import 'package:my_app/core/common/widgets/custom_refresh_indicator.dart';
import 'package:my_app/core/utils/purchases_utils.dart';

import 'package:my_app/features/dashboard/presentation/providers/purchases_providers.dart';
import 'package:my_app/features/dashboard/presentation/widgets/filters/purchases_filters.dart';
import 'package:my_app/features/dashboard/presentation/widgets/header/purchases_header.dart';
import 'package:my_app/features/dashboard/presentation/widgets/purchases_list/purchases_list.dart';
import 'package:my_app/features/dashboard/presentation/widgets/summary/summary_cards.dart';

class PurchasesScreen extends ConsumerStatefulWidget {
  const PurchasesScreen({super.key});

  @override
  ConsumerState<PurchasesScreen> createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends ConsumerState<PurchasesScreen> {
  String _query = '';
  DateTimeRange? _dateRange;

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        ref.read(purchasesScreenControllerProvider.notifier).loadInvoices());
  }

  Future<void> _handleRefresh() async {
    await ref.read(purchasesScreenControllerProvider.notifier).loadInvoices();
  }

  void _onSearchChanged(String query) {
    setState(() => _query = query.trim());
  }

  void _onDateRangeChanged(DateTimeRange? dateRange) {
    setState(() => _dateRange = dateRange);
  }

  void _onFiltersCleared() {
    setState(() {
      _query = '';
      _dateRange = null;
    });
    _handleRefresh();
  }

  void _onExportPdf() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Función de exportar PDF no implementada.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final purchasesState = ref.watch(purchasesScreenControllerProvider);
    final filteredInvoices = PurchasesUtils.filterInvoices(
      invoices: purchasesState.invoices,
      query: _query,
      dateRange: _dateRange,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomRefreshIndicator(
          onRefresh: _handleRefresh,
          child: purchasesState.isLoading
              ? const Center(child: CustomLoadingIndicator())
              : AnimationLimiter(
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 20),
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 400),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(child: widget),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: PurchasesHeader(onExportPdf: _onExportPdf),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SummaryCards(
                      totalPurchases: purchasesState.invoices.length,
                      last30DaysExpense:
                      PurchasesUtils.calculateLast30DaysExpense(
                          purchasesState.invoices),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: PurchasesFilters(
                      query: _query,
                      dateRange: _dateRange,
                      onSearchChanged: _onSearchChanged,
                      onDateRangeChanged: _onDateRangeChanged,
                      onFiltersCleared: _onFiltersCleared,
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (purchasesState.error != null)
                    Center(child: Text(purchasesState.error!)),
                  PurchasesList(invoices: filteredInvoices),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}