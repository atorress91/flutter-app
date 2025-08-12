import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sidebar_constants.dart';

class SidebarMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final bool isCollapsed;
  final VoidCallback onTap;

  const SidebarMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.isCollapsed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Tooltip(
      message: title,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(menuItemBorderRadius),
        splashColor: theme.primary.withAlpha((255 * 0.2).toInt()),
        highlightColor: theme.primary.withAlpha((255 * 0.1).toInt()),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: isCollapsed ? 0 : 12,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.primary.withAlpha((255 * 0.1).toInt())
                : Colors.transparent,
            borderRadius: BorderRadius.circular(menuItemBorderRadius),
          ),
          child: _buildMenuItemContent(context, theme),
        ),
      ),
    );
  }

  Widget _buildMenuItemContent(BuildContext context, ColorScheme theme) {
    return Row(
      mainAxisAlignment: isCollapsed
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        _buildIcon(context, theme),
        if (!isCollapsed) _buildTitle(context),
      ],
    );
  }

  Widget _buildIcon(BuildContext context, ColorScheme theme) {
    return Icon(
      icon,
      color: isSelected
          ? theme.primary
          : Theme.of(context)
          .colorScheme
          .onSurface
          .withAlpha((255 * 0.7).toInt()),
      size: 24,
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            color: isSelected
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context)
                .colorScheme
                .onSurface
                .withAlpha((255 * 0.7).toInt()),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 15,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}