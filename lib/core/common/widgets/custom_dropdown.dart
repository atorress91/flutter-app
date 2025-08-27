import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String labelText;
  final IconData icon;
  final void Function(T?)? onChanged;
  final String Function(T) itemLabel;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.labelText,
    required this.icon,
    required this.onChanged,
    required this.itemLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DropdownButtonFormField<T>(
      initialValue: value,
      items: items
          .map(
            (item) =>
                DropdownMenuItem(value: item, child: Text(itemLabel(item))),
          )
          .toList(),
      onChanged: onChanged,
      style: theme.textTheme.bodyLarge,
      dropdownColor: theme.colorScheme.surface,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface.withAlpha((255 * 0.7).toInt()),
        ),
        prefixIcon: Icon(
          icon,
          color: theme.colorScheme.onSurface.withAlpha((255 * 0.7).toInt()),
          size: 20,
        ),
        filled: true,
        fillColor: theme.colorScheme.surface.withAlpha((255 * 0.2).toInt()),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
        ),
      ),
    );
  }
}
