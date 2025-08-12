import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../core/utils/purchases_utils.dart';
import '../domain/entities/purchase.dart';
import '../widgets/header/purchases_header.dart';
import '../widgets/purchases_list/purchases_list.dart';
import '../widgets/summary/summary_cards.dart';
import '../widgets/filters/purchases_filters.dart';
import '../data/purchases_data.dart';

class PurchasesScreen extends StatefulWidget {
  const PurchasesScreen({super.key});

  @override
  State<PurchasesScreen> createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
  final List<Purchase> _allPurchases = PurchasesData.getSamplePurchases();
  String _query = '';
  DateTimeRange? _dateRange;

  List<Purchase> get _filteredPurchases => PurchasesUtils.filterPurchases(
    purchases: _allPurchases,
    query: _query,
    dateRange: _dateRange,
  );

  double get _last30DaysExpense =>
      PurchasesUtils.calculateLast30DaysExpense(_allPurchases);

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
  }

  void _onExportPdf() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Función de exportar PDF no implementada.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: AnimationLimiter(
          child: ListView(
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
                    totalPurchases: _allPurchases.length,
                    last30DaysExpense: _last30DaysExpense,
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

                PurchasesList(purchases: _filteredPurchases),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
