import 'package:flutter/material.dart' hide DateUtils;
import 'package:my_app/features/dashboard/domain/entities/client.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ClientNodeCard extends StatelessWidget {
  final Client client;

  const ClientNodeCard({super.key, required this.client});

  Widget _buildAvatar(BuildContext context, String url, double radius) {
    final diameter = radius * 2;
    if (url.isEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: const AssetImage('assets/images/image-gallery/avatar/avatar1.png'),
      );
    }
    if (url.startsWith('assets/')) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: AssetImage(url),
      );
    }
    return SizedBox(
      width: diameter,
      height: diameter,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: url,
          width: diameter,
          height: diameter,
          fit: BoxFit.cover,
          memCacheWidth: (diameter * 3).toInt(),
          memCacheHeight: (diameter * 3).toInt(),
          fadeInDuration: const Duration(milliseconds: 150),
          placeholderFadeInDuration: const Duration(milliseconds: 100),
          placeholder: (context, _) => Container(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          errorWidget: (context, _, _) => Image.asset(
            'assets/images/image-gallery/avatar/avatar1.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildInlineChip(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Chip(
      avatar: Icon(Icons.people, size: 14, color: cs.primary),
      label: Text('${client.referrals.length}'),
      visualDensity: VisualDensity.compact,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      backgroundColor: cs.primary.withAlpha((255 * 0.1).toInt()),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    // Reserve a bit of extra space on the right for the overlay toggle button if there are referrals
    final double rightPad = client.referrals.isNotEmpty ? 40 : 10;

    return IntrinsicWidth(
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 8, rightPad, 8),
        constraints: const BoxConstraints(minWidth: 140, maxWidth: 220),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).dividerColor),
          boxShadow: [
            BoxShadow(
              color: cs.shadow.withAlpha((255 * 0.05).toInt()),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAvatar(context, client.image, 18),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    client.username,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    client.level.toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (client.referrals.isNotEmpty) ...[
              const SizedBox(width: 4),
              _buildInlineChip(context),
            ],
          ],
        ),
      ),
    );
  }
}
