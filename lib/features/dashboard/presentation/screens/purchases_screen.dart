import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:my_app/core/utils/purchases_utils.dart';
import 'package:my_app/features/dashboard/data/purchases_data.dart';
import 'package:my_app/features/dashboard/domain/entities/purchase.dart';
import 'package:my_app/features/dashboard/presentation/widgets/filters/purchases_filters.dart';
import 'package:my_app/features/dashboard/presentation/widgets/header/purchases_header.dart';
import 'package:my_app/features/dashboard/presentation/widgets/purchases_list/purchases_list.dart';
import 'package:my_app/features/dashboard/presentation/widgets/summary/summary_cards.dart';

class PurchasesScreen extends StatefulWidget {
  const PurchasesScreen({super.key});

  @override
  State<PurchasesScreen> createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
  // --- ESTADO Y LÓGICA DE DATOS ---
  final List<Purchase> _allPurchases = PurchasesData.getSamplePurchases();
  String _query = '';
  DateTimeRange? _dateRange;

  // -- NUEVO ESTADO PARA LA CARGA --
  bool _isLoading = false;

  // -- GETTERS PARA DATOS FILTRADOS --
  List<Purchase> get _filteredPurchases => PurchasesUtils.filterPurchases(
    purchases: _allPurchases,
    query: _query,
    dateRange: _dateRange,
  );

  double get _last30DaysExpense =>
      PurchasesUtils.calculateLast30DaysExpense(_allPurchases);

  // -- MÉTODOS DE MANEJO DE ESTADO --
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
    // Simulación de 2 segundos de espera.
    await Future.delayed(const Duration(seconds: 2));

    // if (mounted) {
    //   setState(() {
    //     // Actualiza _allPurchases con los nuevos datos.
    //   });
    // }
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
    // Opcional: Recargar los datos desde la API al limpiar filtros.
    // _handleRefresh();
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
        // Se envuelve el contenido con RefreshIndicator
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : AnimationLimiter(
                  // Se añade physics para asegurar que el scroll esté siempre activo
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
      ),
    );
  }
}
