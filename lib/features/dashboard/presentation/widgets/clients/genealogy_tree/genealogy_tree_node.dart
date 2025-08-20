import 'package:flutter/material.dart';
import 'package:my_app/features/dashboard/domain/entities/client.dart';

import 'client_node_card.dart';
import 'children_block.dart';

class GenealogyTreeNode extends StatelessWidget {
  final Client client;

  const GenealogyTreeNode({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClientNodeCard(client: client),
        const SizedBox(height: 8),
        if (client.referrals.isNotEmpty)
          ChildrenBlock(
            childCount: client.referrals.length,
            childBuilder: (i) => GenealogyTreeNode(client: client.referrals[i]),
          ),
      ],
    );
  }
}
