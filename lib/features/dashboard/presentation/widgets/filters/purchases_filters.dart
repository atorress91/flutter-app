import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'search_field.dart';
import 'date_range_picker_button.dart';
import 'clear_filters_button.dart';

class PurchasesFilters extends StatelessWidget {
  final String query;
  final DateTimeRange? dateRange;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<DateTimeRange?> onDateRangeChanged;
  final VoidCallback onFiltersCleared;

  const PurchasesFilters({
    super.key,
    required this.query,
    required this.dateRange,
    required this.onSearchChanged,
    required this.onDateRangeChanged,
    required this.onFiltersCleared,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filtros',
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        SearchField(
          initialValue: query,
          onChanged: onSearchChanged,
        ),
        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: DateRangePickerButton(
                dateRange: dateRange,
                onDateRangeChanged: onDateRangeChanged,
              ),
            ),
            const SizedBox(width: 12),
            ClearFiltersButton(onPressed: onFiltersCleared),
          ],
        ),
      ],
    );
  }
}