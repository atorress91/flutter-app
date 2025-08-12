import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// --- NUEVO MODELO DE DATOS MEJORADO ---
enum PurchaseStatus { completado, procesando, devuelto }

class _Purchase {
  final String noFa;
  final DateTime fecha;
  final String modelo;
  final String detalle;
  final double monto;
  final PurchaseStatus status;

  _Purchase({
    required this.noFa,
    required this.fecha,
    required this.modelo,
    required this.detalle,
    required this.monto,
    required this.status,
  });
}

class PurchasesScreen extends StatefulWidget {
  const PurchasesScreen({super.key});

  @override
  State<PurchasesScreen> createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  DateTimeRange? _dateRange;
  String _query = '';

  // --- DATOS DE EJEMPLO ACTUALIZADOS ---
  final List<_Purchase> _all = [
    // _Purchase(
    //   noFa: 'FA-000127',
    //   fecha: DateTime(2025, 8, 8),
    //   modelo: 'QX-9',
    //   detalle: 'Equipo profesional QX-9',
    //   monto: 1250.00,
    //   status: PurchaseStatus.completado,
    // ),
    // _Purchase(
    //   noFa: 'FA-000126',
    //   fecha: DateTime(2025, 7, 28),
    //   modelo: 'ZX-100',
    //   detalle: 'Reposición de stock para taller',
    //   monto: 350.50,
    //   status: PurchaseStatus.completado,
    // ),
    // _Purchase(
    //   noFa: 'FA-000125',
    //   fecha: DateTime(2025, 7, 1),
    //   modelo: 'AB-500',
    //   detalle: 'Kit de accesorios y consumibles',
    //   monto: 85.75,
    //   status: PurchaseStatus.procesando,
    // ),
    // _Purchase(
    //   noFa: 'FA-000124',
    //   fecha: DateTime(2025, 6, 15),
    //   modelo: 'ZX-200',
    //   detalle: 'Compra de equipo de diagnóstico',
    //   monto: 2400.00,
    //   status: PurchaseStatus.devuelto,
    // ),
    // _Purchase(
    //   noFa: 'FA-000123',
    //   fecha: DateTime(2025, 6, 2),
    //   modelo: 'ZX-100',
    //   detalle: 'Repuesto para sistema de enfriamiento',
    //   monto: 120.00,
    //   status: PurchaseStatus.completado,
    // ),
  ];

  List<_Purchase> get _filtered {
    Iterable<_Purchase> items = _all;
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      items = items.where(
        (p) =>
            p.noFa.toLowerCase().contains(q) ||
            p.modelo.toLowerCase().contains(q) ||
            p.detalle.toLowerCase().contains(q),
      );
    }
    if (_dateRange != null) {
      final start = DateUtils.dateOnly(_dateRange!.start);
      final end = DateUtils.dateOnly(_dateRange!.end);
      items = items.where(
        (p) =>
            !DateUtils.dateOnly(p.fecha).isBefore(start) &&
            !DateUtils.dateOnly(p.fecha).isAfter(end),
      );
    }
    return items.toList();
  }

  double get _gastoUltimos30Dias {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    return _all
        .where((p) => p.fecha.isAfter(thirtyDaysAgo))
        .fold(0.0, (sum, item) => sum + item.monto);
  }

  Future<void> _pickDateRange() async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: now,
      initialDateRange: _dateRange,
      helpText: 'Selecciona un rango de fechas',
      saveText: 'Aplicar',
    );
    if (picked != null) setState(() => _dateRange = picked);
  }

  void _clearFilters() {
    setState(() {
      _searchCtrl.clear();
      _query = '';
      _dateRange = null;
    });
  }

  void _exportPdf() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Función de exportar PDF no implementada.')),
    );
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    final colorScheme = Theme.of(context).colorScheme;

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
                // --- HEADER ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Mis compras',
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                      Tooltip(
                        message: 'Exportar PDF',
                        child: TextButton.icon(
                          onPressed: _exportPdf,
                          icon: const Icon(Icons.picture_as_pdf_outlined),
                          label: const Text('Exportar'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- TARJETAS DE RESUMEN ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: _SummaryCard(
                          icon: Icons.receipt_long,
                          title: 'Total Compras',
                          value: _all.length.toString(),
                          color: Colors.blue.shade400,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _SummaryCard(
                          icon: Icons.account_balance_wallet_outlined,
                          title: 'Gasto (últ. 30 días)',
                          value:
                              'CRC ${_gastoUltimos30Dias.toStringAsFixed(2)}',
                          color: Colors.green.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- BARRA DE FILTROS ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Filtros',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _searchCtrl,
                        onChanged: (v) => setState(() => _query = v.trim()),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Buscar por No. Factura, Modelo...',
                          filled: true,
                          fillColor: colorScheme.surface,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _pickDateRange,
                              icon: const Icon(Icons.date_range_outlined),
                              label: Text(
                                _dateRange == null
                                    ? 'Cualquier fecha'
                                    : '${_formatDate(_dateRange!.start)} - ${_formatDate(_dateRange!.end)}',
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: colorScheme.onSurface,
                                side: BorderSide(
                                  color: colorScheme.outline.withAlpha(
                                    (255 * 0.5).toInt(),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          IconButton(
                            onPressed: _clearFilters,
                            icon: const Icon(Icons.clear),
                            tooltip: 'Limpiar filtros',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- LISTA DE COMPRAS ---
                if (_filtered.isEmpty)
                  _NoResultsWidget()
                else
                  ..._filtered.map(
                    (purchase) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      child: _PurchaseCard(purchase: purchase),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }
}

// --- WIDGETS PERSONALIZADOS PARA EL NUEVO DISEÑO ---

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _SummaryCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color.withAlpha((255 * 0.15).toInt()),
            radius: 20,
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _PurchaseCard extends StatelessWidget {
  final _Purchase purchase;

  const _PurchaseCard({required this.purchase});

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outline.withAlpha((255 * 0.2).toInt()),
        ),
      ),
      color: colorScheme.surface,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // TODO: Implementar navegación a la vista de detalle de la compra
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    purchase.noFa,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  Text(
                    _formatDate(purchase.fecha),
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              Text(
                purchase.modelo,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                purchase.detalle,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _StatusChip(status: purchase.status),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }
}

class _StatusChip extends StatelessWidget {
  final PurchaseStatus status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final Map<PurchaseStatus, dynamic> styles = {
      PurchaseStatus.completado: {
        'label': 'Completado',
        'color': Colors.green.shade700,
        'icon': Icons.check_circle_outline,
      },
      PurchaseStatus.procesando: {
        'label': 'Procesando',
        'color': Colors.orange.shade700,
        'icon': Icons.hourglass_top_outlined,
      },
      PurchaseStatus.devuelto: {
        'label': 'Devuelto',
        'color': Colors.red.shade700,
        'icon': Icons.cancel_outlined,
      },
    };

    final style = styles[status]!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: style['color'].withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(style['icon'], color: style['color'], size: 14),
          const SizedBox(width: 6),
          Text(
            style['label'],
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: style['color'],
            ),
          ),
        ],
      ),
    );
  }
}

class _NoResultsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No se encontraron compras',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Prueba ajustando los filtros o usando otro término de búsqueda.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
