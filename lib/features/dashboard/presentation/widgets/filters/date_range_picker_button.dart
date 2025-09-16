import 'package:flutter/material.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import 'package:my_app/core/utils/date_formatter.dart';

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
    final l10n = AppLocalizations.of(context);
    
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: now,
      initialDateRange: dateRange,
      helpText: l10n.purchasesDateRangeHelp,
      saveText: l10n.purchasesDateRangeSave,
    );

    if (picked != null) {
      onDateRangeChanged(picked);
    }
  }

  String _formatDateRange(DateTimeRange dateRange) {
    final startDate = DateFormatter.ddMMyyyy(dateRange.start);
    final endDate = DateFormatter.ddMMyyyy(dateRange.end);
    return '$startDate - $endDate';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return OutlinedButton.icon(
      onPressed: () => _pickDateRange(context),
      icon: const Icon(Icons.date_range_outlined),
      label: Text(
        dateRange == null ? l10n.purchasesAnyDate : _formatDateRange(dateRange!),
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.onSurface,
        side: BorderSide(
          color: colorScheme.outline.withAlpha((255 * 0.5).toInt()),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
