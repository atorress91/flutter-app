import 'package:flutter/material.dart';
import 'package:my_app/features/dashboard/domain/entities/client.dart';
import 'genealogy_tree/genealogy_tree_root.dart';

class OptimizedGenealogyView extends StatefulWidget {
  final String rootTitle;
  final List<Client> directClients;

  const OptimizedGenealogyView({
    super.key,
    required this.rootTitle,
    required this.directClients,
  });

  @override
  State<OptimizedGenealogyView> createState() => _OptimizedGenealogyViewState();
}

class _OptimizedGenealogyViewState extends State<OptimizedGenealogyView> {
  final TransformationController _controller = TransformationController();
  final double _minScale = 0.2;
  final double _maxScale = 3.0;

  Offset? _lastTapDownPosition;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _resetView() {
    setState(() {
      _controller.value = Matrix4.identity();
    });
  }

  void _zoom(double delta, {Offset? focalInViewport}) {
    final m = _controller.value.clone();
    final currentScale = m.getMaxScaleOnAxis();
    final target = (currentScale * delta).clamp(_minScale, _maxScale);

    // Scale around a focal point in the viewport (GestureDetector local position)
    final Size size = context.size ?? const Size(0, 0);
    final Offset focal = focalInViewport ?? size.center(Offset.zero);

    final Matrix4 translate1 = Matrix4.identity()..translate(-focal.dx, -focal.dy);
    final Matrix4 scale = Matrix4.identity()..scale(target / currentScale);
    final Matrix4 translate2 = Matrix4.identity()..translate(focal.dx, focal.dy);

    setState(() {
      _controller.value = m * translate2 * scale * translate1;
    });
  }

  void _handleDoubleTap() {
    final currentScale = _controller.value.getMaxScaleOnAxis();
    if ((currentScale - 1.0).abs() < 0.05) {
      _zoom(1.6, focalInViewport: _lastTapDownPosition);
    } else {
      _resetView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth > 0 ? constraints.maxWidth : 400;
        final double height = constraints.maxHeight > 0 ? constraints.maxHeight : 500;

        return Stack(
          children: [
            SizedBox(
              width: width,
              height: height,
              child: GestureDetector(
                onDoubleTapDown: (details) => _lastTapDownPosition = details.localPosition,
                onDoubleTap: _handleDoubleTap,
                child: InteractiveViewer(
                  transformationController: _controller,
                  minScale: _minScale,
                  maxScale: _maxScale,
                  boundaryMargin: const EdgeInsets.all(100),
                  constrained: true, // Cambio a true para evitar constraints indefinidas
                  panEnabled: true,
                  scaleEnabled: true,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: widget.directClients.isEmpty
                          ? Container(
                              width: width,
                              height: height,
                              alignment: Alignment.center,
                              child: const Text('No hay clientes directos'),
                            )
                          : GenealogyTreeRoot(
                              title: widget.rootTitle,
                              children: widget.directClients,
                            ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 12,
              bottom: 12,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _ZoomButton(
                    icon: Icons.add,
                    tooltip: 'Acercar',
                    onPressed: () => _zoom(1.2),
                  ),
                  const SizedBox(height: 8),
                  _ZoomButton(
                    icon: Icons.remove,
                    tooltip: 'Alejar',
                    onPressed: () => _zoom(1 / 1.2),
                  ),
                  const SizedBox(height: 8),
                  _ZoomButton(
                    icon: Icons.refresh,
                    tooltip: 'Restablecer vista',
                    onPressed: _resetView,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ZoomButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  const _ZoomButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Theme.of(context).colorScheme.primaryContainer,
        shape: const CircleBorder(),
        elevation: 4,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              icon,
              size: 22,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}
