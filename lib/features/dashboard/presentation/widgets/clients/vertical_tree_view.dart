import 'package:flutter/material.dart';
import 'package:my_app/features/dashboard/domain/entities/client.dart';
import 'client_tree_node.dart';

class VerticalTreeView extends StatelessWidget {
  final List<Client> directClients;

  VerticalTreeView({
    super.key,
    required this.directClients,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: directClients
            .map((client) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ClientTreeNode(client: client),
                ))
            .toList(),
      ),
    );
  }
}