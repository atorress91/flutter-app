
import 'package:flutter/material.dart';

import '../../../../core/utils/date_formatter.dart';

class DateRangePickerButton extends StatelessWidget {
  final DateTimeRange? dateRange;
  final ValueChanged<DateTimeRange?> onDateRangeChanged;

  const DateRangePickerButton({
    super.key,
    required this.dateRange,
    required this.onDateRangeChanged,
  });

  Future<void> _pickDateRange(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: now,
      initialDateRange: dateRange,
      helpText: 'Selecciona un rango de fechas',
      saveText: 'Aplicar',
    );

    if (picked != null) {
      onDateRangeChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return OutlinedButton.icon(
      onPressed: () => _pickDateRange(context),
      icon: const Icon(Icons.date_range_outlined),
      label: Text(
        dateRange == null
            ? 'Cualquier fecha'
            : DateFormatter.ddMMyyyy(dateRange! as DateTime),
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.onSurface,
        side: BorderSide(
          color: colorScheme.outline.withAlpha((255 * 0.5).toInt()),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}