import 'package:flutter/material.dart';
import 'package:my_app/features/dashboard/domain/entities/client.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'client_node_card.dart';
import 'children_block.dart';

class GenealogyTreeNode extends StatefulWidget {
  final Client client;

  const GenealogyTreeNode({super.key, required this.client});

  @override
  State<GenealogyTreeNode> createState() => _GenealogyTreeNodeState();
}

class _GenealogyTreeNodeState extends State<GenealogyTreeNode> {
  bool _expanded = false;

  void _prefetchChildrenAvatars() {
    for (final c in widget.client.referrals) {
      final url = c.image;
      if (url.isNotEmpty && !url.startsWith('assets/')) {
        precacheImage(CachedNetworkImageProvider(url), context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final client = widget.client;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClientNodeCard(client: client),
            if (client.referrals.isNotEmpty)
              IconButton(
                tooltip: _expanded ? 'Contraer' : 'Expandir',
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() => _expanded = !_expanded);
                  if (!_expanded) return;
                  _prefetchChildrenAvatars();
                },
              ),
          ],
        ),
        const SizedBox(height: 8),
        if (client.referrals.isNotEmpty && _expanded)
          ChildrenBlock(
            childCount: client.referrals.length,
            childBuilder: (i) => GenealogyTreeNode(client: client.referrals[i]),
          ),
      ],
    );
  }
}
