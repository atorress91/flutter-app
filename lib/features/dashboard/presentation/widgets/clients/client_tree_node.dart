import 'package:flutter/material.dart' hide DateUtils;
import 'package:my_app/core/utils/date_formatter.dart';
import 'package:my_app/features/dashboard/domain/entities/client.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

  void _prefetchChildrenAvatars() {
    for (final c in widget.client.referrals) {
      final url = c.avatarUrl;
      if (url.isNotEmpty && !url.startsWith('assets/')) {
        precacheImage(CachedNetworkImageProvider(url), context);
      }
    }
  }

  Widget _buildAvatar(String url, double radius) {
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
            child: const Center(
              child: SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
          errorWidget: (context, _, _) => Image.asset(
            'assets/images/image-gallery/avatar/avatar1.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

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
            _buildAvatar(client.avatarUrl, 20),
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
                onPressed: () {
                  setState(() => _expanded = !_expanded);
                  if (!_expanded) return;
                  _prefetchChildrenAvatars();
                },
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
