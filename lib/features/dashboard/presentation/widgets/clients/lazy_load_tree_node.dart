import 'package:flutter/material.dart';
import 'package:my_app/features/dashboard/domain/entities/client.dart';
import 'package:my_app/features/dashboard/presentation/widgets/clients/visibility_detector.dart';

import 'optimized_node_widget.dart';

class LazyLoadTreeNode extends StatefulWidget {
  final List<Client> clients;
  final Function(String) onNodeVisible;
  final Map<String, Widget> cachedWidgets;

  const LazyLoadTreeNode({
    super.key,
    required this.clients,
    required this.onNodeVisible,
    required this.cachedWidgets,
  });

  @override
  State<LazyLoadTreeNode> createState() => _LazyLoadTreeNodeState();
}

class _LazyLoadTreeNodeState extends State<LazyLoadTreeNode> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.clients.first.id.toString()),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0 && !_isVisible) {
          _isVisible = true;
          widget.onNodeVisible(widget.clients.first.id.toString());
        }
      },
      child: _isVisible ? _buildVisibleContent() : _buildPlaceholder(),
    );
  }

  Widget _buildVisibleContent() {
    final cacheKey = 'tree_${widget.clients.first.id}';
    return widget.cachedWidgets[cacheKey] ??= _createContent();
  }

  Widget _createContent() {
    return Column(
      children: widget.clients.map((client) {
        return OptimizedNodeWidget(
          client: client,
          onExpand: () => widget.onNodeVisible(client.id.toString()),
        );
      }).toList(),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 100,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}
