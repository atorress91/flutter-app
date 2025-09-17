import 'package:flutter/material.dart' hide DateUtils;
import 'package:my_app/core/utils/date_formatter.dart';
import 'package:my_app/features/dashboard/domain/entities/client.dart';

class ClientNodeCard extends StatelessWidget {
  final Client client;

  const ClientNodeCard({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      constraints: const BoxConstraints(minWidth: 150),
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
          CircleAvatar(
            radius: 18,
            backgroundImage: (client.avatarUrl.isNotEmpty)
                ? (client.avatarUrl.startsWith('assets/') 
                    ? AssetImage(client.avatarUrl)
                    : NetworkImage(client.avatarUrl)) as ImageProvider
                : const AssetImage('assets/images/image-gallery/avatar/avatar1.png') as ImageProvider,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  client.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Desde ${DateFormatter.ddMMyyyy(client.joinDate)}',
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (client.referrals.isNotEmpty) ...[
            const SizedBox(width: 8),
            Chip(
              avatar: Icon(Icons.people, size: 14, color: cs.primary),
              label: Text('${client.referrals.length}'),
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.all(4),
              backgroundColor: cs.primary.withAlpha((255 * 0.1).toInt()),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ],
      ),
    );
  }
}
