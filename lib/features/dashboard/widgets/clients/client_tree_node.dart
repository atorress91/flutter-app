import 'package:flutter/material.dart' hide DateUtils;

import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/client.dart';

class ClientTreeNode extends StatelessWidget {
  final Client client;
  final double indentation;
  final bool isLast;

  const ClientTreeNode({
    super.key,
    required this.client,
    this.indentation = 0.0,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: indentation),
            if (indentation > 0)
              Text(
                isLast ? '└─ ' : '├─ ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: 16,
                ),
              ),
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(client.avatarUrl),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    client.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Miembro desde: ${DateFormatter.long(client.joinDate)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            if (client.referrals.isNotEmpty)
              Chip(
                avatar: Icon(
                  Icons.people,
                  size: 14,
                  color: Theme.of(context).colorScheme.primary,
                ),
                label: Text('${client.referrals.length}'),
                visualDensity: VisualDensity.compact,
                padding: const EdgeInsets.all(4),
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.primary.withAlpha((255 * 0.1).toInt()),
              ),
          ],
        ),
        if (client.referrals.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: indentation + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < client.referrals.length; i++)
                  ClientTreeNode(
                    client: client.referrals[i],
                    indentation: 20.0,
                    isLast: i == client.referrals.length - 1,
                  ),
              ],
            ),
          ),
      ],
    );
  }
}