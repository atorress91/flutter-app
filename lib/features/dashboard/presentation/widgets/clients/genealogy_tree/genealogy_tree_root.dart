import 'package:flutter/material.dart';
import 'package:my_app/features/dashboard/domain/entities/client.dart';
import 'root_node.dart';
import 'children_block.dart';
import 'genealogy_tree_node.dart';

class GenealogyTreeRoot extends StatelessWidget {
  final String title;
  final List<Client> children;

  const GenealogyTreeRoot({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RootNode(
            title: title,
            icon: Icons.person_search,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 8),
          if (children.isNotEmpty)
            ChildrenBlock(
              childCount: children.length,
              childBuilder: (i) => GenealogyTreeNode(client: children[i]),
            )
          else
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Sin clientes directos',
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withAlpha((255 * 0.6).toInt()),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
