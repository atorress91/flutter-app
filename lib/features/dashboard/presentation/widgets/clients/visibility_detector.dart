import 'package:flutter/cupertino.dart';

class VisibilityDetector extends StatefulWidget {
  final Widget child;
  final Function(VisibilityInfo) onVisibilityChanged;
  final Key key;

  const VisibilityDetector({
    required this.key,
    required this.child,
    required this.onVisibilityChanged,
  }) : super(key: key);

  @override
  State<VisibilityDetector> createState() => _VisibilityDetectorState();
}

class _VisibilityDetectorState extends State<VisibilityDetector> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });
  }

  void _checkVisibility() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null && renderBox.hasSize) {
      final offset = renderBox.localToGlobal(Offset.zero);
      final Size size = renderBox.size;
      final Rect bounds = offset & size;

      final Size screenSize = MediaQuery.of(context).size;
      final Rect screenBounds = Offset.zero & screenSize;

      final Rect intersection = bounds.intersect(screenBounds);
      final double visibleFraction = intersection.isEmpty
          ? 0.0
          : (intersection.width * intersection.height) /
                (size.width * size.height);

      widget.onVisibilityChanged(
        VisibilityInfo(
          visibleFraction: visibleFraction,
          size: size,
          offset: offset,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _checkVisibility();
        return false;
      },
      child: widget.child,
    );
  }
}

class VisibilityInfo {
  final double visibleFraction;
  final Size size;
  final Offset offset;

  VisibilityInfo({
    required this.visibleFraction,
    required this.size,
    required this.offset,
  });
}
