import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget button = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        padding: padding,
        minimumSize: Size(width ?? double.infinity, height ?? 50),
        maximumSize: width != null 
            ? Size(width!, height ?? 50)
            : Size.fromHeight(height ?? 50),
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: theme.colorScheme.onPrimary,
              ),
            )
          : Text(text),
    );

    // Solo usar SizedBox si se necesita un width específico
    if (width != null) {
      return SizedBox(
        width: width,
        height: height ?? 50,
        child: button,
      );
    }

    return SizedBox(
      width: double.infinity,
      height: height ?? 50,
      child: button,
    );
  }
}
