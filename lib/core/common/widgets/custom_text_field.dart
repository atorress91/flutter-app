import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final bool isCompact;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.onFieldSubmitted,
    this.isCompact = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final borderRadius = widget.isCompact ? 12.0 : 16.0;
    final iconSize = widget.isCompact ? 18.0 : 22.0;
    final fontSize = widget.isCompact ? 14.0 : 16.0;
    final verticalPadding = widget.isCompact ? 14.0 : 18.0;

    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: _isFocused
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.2),
                    blurRadius: widget.isCompact ? 8 : 12,
                    spreadRadius: 0,
                    offset: Offset(0, widget.isCompact ? 2 : 4),
                  ),
                ]
              : [],
        ),
        child: TextFormField(
          controller: widget.controller,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: fontSize,
          ),
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          textCapitalization: widget.textCapitalization,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: theme.textTheme.bodyMedium?.copyWith(
              color: _isFocused
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface.withOpacity(0.6),
              fontWeight: FontWeight.w500,
              fontSize: widget.isCompact ? 13 : null,
            ),
            floatingLabelStyle: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
              fontSize: widget.isCompact ? 12 : null,
            ),
            prefixIcon: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.all(widget.isCompact ? 10 : 12),
              child: Icon(
                widget.icon,
                color: _isFocused
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withOpacity(0.5),
                size: iconSize,
              ),
            ),
            suffixIcon: widget.suffixIcon,
            filled: true,
            fillColor: isDark
                ? Colors.white.withOpacity(0.05)
                : theme.colorScheme.surface.withOpacity(0.8),
            contentPadding: EdgeInsets.symmetric(
              horizontal: widget.isCompact ? 16 : 20,
              vertical: verticalPadding,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: theme.colorScheme.outline.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: theme.colorScheme.outline.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
                width: 2,
              ),
            ),
            errorStyle: TextStyle(
              fontSize: widget.isCompact ? 11 : 12,
            ),
          ),
          validator: widget.validator,
        ),
      ),
    );
  }
}
