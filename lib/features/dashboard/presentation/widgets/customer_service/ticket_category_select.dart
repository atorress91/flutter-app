import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/features/dashboard/data/ticket_category.dart';

class TicketCategorySelector extends StatelessWidget {
  final TicketCategory? selectedCategory;
  final ValueChanged<TicketCategory?> onCategoryChanged;
  final String labelText;

  const TicketCategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
    this.labelText = 'Categoría',
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<TicketCategory>(
          initialValue: selectedCategory,
          decoration: InputDecoration(
            hintText: 'Selecciona una categoría',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: colorScheme.outline.withAlpha((255 * 0.4).toInt()),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: colorScheme.outline.withAlpha((255 * 0.4).toInt()),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          onChanged: onCategoryChanged,
          items: TicketCategory.values.map((category) {
            return DropdownMenuItem(
              value: category,
              child: Text(category.name),
            );
          }).toList(),
          style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
          icon: Icon(
            Icons.arrow_drop_down,
            color: colorScheme.onSurfaceVariant,
          ),
          isExpanded: true,
        ),
      ],
    );
  }
}
