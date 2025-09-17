import 'package:flutter/cupertino.dart';
import 'package:my_app/features/dashboard/domain/entities/client.dart';
import 'package:my_app/features/dashboard/presentation/widgets/clients/lazy_load_tree_node.dart';
import 'package:my_app/features/dashboard/presentation/widgets/clients/performance_manager.dart';

class LazyTreeWidget extends StatefulWidget {
  final List<Client> clients;
  final bool genealogyView;

  const LazyTreeWidget({
    super.key,
    required this.clients,
    required this.genealogyView,
  });

  @override
  State<LazyTreeWidget> createState() => _LazyTreeWidgetState();
}

class _LazyTreeWidgetState extends State<LazyTreeWidget> {
  final Map<String, bool> _loadedNodes = {};
  final Map<String, Widget> _cachedWidgets = {};

  @override
  Widget build(BuildContext context) {
    return widget.genealogyView ? _buildGenealogyView() : _buildVerticalView();
  }

  Widget _buildGenealogyView() {
    return InteractiveViewer(
      minScale: 0.1,
      maxScale: 5.0,
      boundaryMargin: const EdgeInsets.all(1000),
      constrained: false,
      child: Container(
        padding: const EdgeInsets.all(100),
        child: LazyLoadTreeNode(
          clients: widget.clients,
          onNodeVisible: _onNodeVisible,
          cachedWidgets: _cachedWidgets,
        ),
      ),
    );
  }

  Widget _buildVerticalView() {
    return ListView.builder(
      itemCount: _countVisibleNodes(),
      itemBuilder: (context, index) {
        return _buildLazyNode(index);
      },
    );
  }

  int _countVisibleNodes() {
    return PerformanceManager.cached(
      'node_count_${widget.clients.length}',
      () => _recursiveCount(widget.clients),
    );
  }

  int _recursiveCount(List<Client> clients) {
    int count = clients.length;
    for (final client in clients) {
      if (_loadedNodes[client.id] == true) {
        count += _recursiveCount(client.referrals);
      }
    }
    return count;
  }

  Widget _buildLazyNode(int index) {
    final nodeKey = 'node_$index';
    return _cachedWidgets[nodeKey] ??= _createNode(index);
  }

  Widget _createNode(int index) {
    // Lógica para crear nodo basado en índice
    return Container(); // Simplificado por brevedad
  }

  void _onNodeVisible(String nodeId) {
    if (!_loadedNodes.containsKey(nodeId)) {
      setState(() {
        _loadedNodes[nodeId] = true;
      });
    }
  }
}
