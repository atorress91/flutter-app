import 'package:flutter/material.dart';
import 'connectors_painter.dart';

class ChildrenBlock extends StatelessWidget {
  final int childCount;
  final Widget Function(int index) childBuilder;

  const ChildrenBlock({
    super.key,
    required this.childCount,
    required this.childBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 30,
            child: CustomPaint(
              painter: ConnectorsPainter(
                childCount: childCount,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(childCount, (i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: childBuilder(i),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}