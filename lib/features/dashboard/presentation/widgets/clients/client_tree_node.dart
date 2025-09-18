import 'package:flutter/material.dart' hide DateUtils;
import 'package:my_app/core/utils/date_formatter.dart';
import 'package:my_app/features/dashboard/domain/entities/client.dart';

class ClientTreeNode extends StatefulWidget {
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
  State<ClientTreeNode> createState() => _ClientTreeNodeState();
}

class _ClientTreeNodeState extends State<ClientTreeNode> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final client = widget.client;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: widget.indentation),
            if (widget.indentation > 0)
              Text(
                widget.isLast ? '└─ ' : '├─ ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: 16,
                ),
              ),
            CircleAvatar(
              radius: 20,
              backgroundImage: (client.avatarUrl.isNotEmpty)
                  ? (client.avatarUrl.startsWith('assets/')
                      ? AssetImage(client.avatarUrl)
                      : NetworkImage(client.avatarUrl)) as ImageProvider
                  : const AssetImage('assets/images/image-gallery/avatar/avatar1.png'),
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
                    'Miembro desde: ${DateFormatter.ddMMyyyy(client.joinDate)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            if (client.referrals.isNotEmpty) ...[
              IconButton(
                tooltip: _expanded ? 'Contraer' : 'Expandir',
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () => setState(() => _expanded = !_expanded),
              ),
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
          ],
        ),
        if (client.referrals.isNotEmpty && _expanded)
          Padding(
            padding: EdgeInsets.only(left: widget.indentation + 10),
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
