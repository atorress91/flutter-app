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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Card del nodo con botón de expansión superpuesto
        Stack(
          alignment: Alignment.topRight,
          children: [
            ClientNodeCard(client: client),
            if (client.referrals.isNotEmpty)
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  tooltip: _expanded ? 'Contraer' : 'Expandir',
                  iconSize: 18,
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.all(4),
                  constraints: const BoxConstraints.tightFor(width: 30, height: 30),
                  icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() => _expanded = !_expanded);
                    if (!_expanded) return;
                    _prefetchChildrenAvatars();
                  },
                ),
              ),
          ],
        ),
        // Expansión vertical hacia abajo (como FamilySearch)
        if (client.referrals.isNotEmpty && _expanded) ...[
          const SizedBox(height: 20),
          // Hijos organizados en filas debajo del padre
          ChildrenBlock(
            childCount: client.referrals.length,
            childBuilder: (i) => GenealogyTreeNode(client: client.referrals[i]),
          ),
        ],
      ],
    );
  }
}
