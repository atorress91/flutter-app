import 'package:flutter/material.dart';
import 'package:my_app/features/dashboard/domain/entities/client.dart';
import 'genealogy_tree/genealogy_tree_root.dart';

class OptimizedGenealogyView extends StatelessWidget {
  final String rootTitle;
  final List<Client> directClients;

  OptimizedGenealogyView({
    super.key,
    required this.rootTitle,
    required this.directClients,
  });

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: 0.1,
      maxScale: 3.0,
      boundaryMargin: const EdgeInsets.all(100),
      constrained: false,
      child: Center(
        child: GenealogyTreeRoot(
          title: rootTitle,
          children: directClients,
        ),
      ),
    );
  }
}