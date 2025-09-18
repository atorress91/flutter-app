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
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Nodo raíz en la parte superior
              RootNode(
                title: title,
                icon: Icons.person_search,
                color: Theme.of(context).colorScheme.primary,
              ),
              // Espacio y conectores hacia los hijos
              if (children.isNotEmpty) ...[
                const SizedBox(height: 20),
                // Los hijos se expanden hacia abajo en filas
                ChildrenBlock(
                  childCount: children.length,
                  childBuilder: (i) => GenealogyTreeNode(client: children[i]),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
