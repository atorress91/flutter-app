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

  // Configuración para adaptarse al espacio disponible
  static const double _minSlotWidth = 160.0; // Ancho mínimo para cada slot
  static const double _maxSlotWidth = 220.0; // Ancho máximo para cada slot

  @override
  Widget build(BuildContext context) {
    if (childCount <= 0) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        // Validación segura del ancho disponible para evitar NaN/Infinity
        double availableWidth;
        if (constraints.maxWidth.isFinite && constraints.maxWidth > 0) {
          availableWidth = constraints.maxWidth;
        } else {
          // Fallback seguro usando MediaQuery
          final screenWidth = MediaQuery.of(context).size.width;
          availableWidth = screenWidth > 0 ? screenWidth * 0.8 : 300.0;
        }

        // Validar que availableWidth sea válido antes de hacer cálculos
        if (!availableWidth.isFinite || availableWidth <= 0) {
          availableWidth = 300.0; // Valor por defecto seguro
        }

        // Cálculo seguro del número máximo de hijos por fila
        int maxChildrenPerRow;
        if (availableWidth >= _minSlotWidth) {
          final ratio = availableWidth / _minSlotWidth;
          if (ratio.isFinite) {
            maxChildrenPerRow = ratio.floor().clamp(1, 3);
          } else {
            maxChildrenPerRow = 1;
          }
        } else {
          maxChildrenPerRow = 1;
        }

        // Limitar el número de hijos por fila al número total de hijos
        final int actualChildrenPerRow = maxChildrenPerRow.clamp(1, childCount);

        // Calcular número de filas necesarias
        final int rowCount = (childCount / actualChildrenPerRow).ceil();
        final bool needsMultipleRows = rowCount > 1;

        // Calcular ancho óptimo de slot de forma segura
        final double slotWidth = actualChildrenPerRow > 0
            ? (availableWidth / actualChildrenPerRow).clamp(_minSlotWidth, _maxSlotWidth)
            : _minSlotWidth;

        final Color connectorColor = Theme.of(context).colorScheme.outline;

        if (!needsMultipleRows) {
          // Implementación para pocos hijos: una sola fila
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Conector
              SizedBox(
                height: 30,
                width: availableWidth,
                child: CustomPaint(
                  painter: ConnectorsPainter(
                    childCount: childCount,
                    color: connectorColor,
                  ),
                ),
              ),
              // Fila de hijos
              _buildChildRow(
                rowItemCount: childCount,
                startIdx: 0,
                slotWidth: slotWidth,
                availableWidth: availableWidth,
              ),
            ],
          );
        } else {
          // Implementación para muchos hijos: múltiples filas
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Línea vertical desde el padre
              SizedBox(
                height: 20,
                width: availableWidth,
                child: Center(
                  child: CustomPaint(
                    painter: SimpleCenterLineConnector(
                      color: connectorColor,
                    ),
                  ),
                ),
              ),
              // Filas de hijos
              ...List.generate(rowCount, (rowIndex) {
                final int startIdx = rowIndex * actualChildrenPerRow;
                final int endIdx = (startIdx + actualChildrenPerRow).clamp(0, childCount);
                final int rowItemCount = endIdx - startIdx;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (rowIndex > 0) const SizedBox(height: 20),
                    // Conector horizontal para la fila
                    SizedBox(
                      height: 20,
                      width: availableWidth,
                      child: CustomPaint(
                        painter: HorizontalRowConnector(
                          childCount: rowItemCount,
                          color: connectorColor,
                        ),
                      ),
                    ),
                    // Fila de hijos
                    _buildChildRow(
                      rowItemCount: rowItemCount,
                      startIdx: startIdx,
                      slotWidth: slotWidth,
                      availableWidth: availableWidth,
                    ),
                  ],
                );
              }),
            ],
          );
        }
      },
    );
  }

  // Helper para construir una fila de hijos con distribución equitativa
  Widget _buildChildRow({
    required int rowItemCount,
    required int startIdx,
    required double slotWidth,
    required double availableWidth,
  }) {
    if (rowItemCount <= 0) return const SizedBox.shrink();

    return SizedBox(
      width: availableWidth,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: rowItemCount < 2
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(rowItemCount, (i) {
          final int childIndex = startIdx + i;
          // Usar Flexible con fit: FlexFit.tight para asegurar que cada hijo se ajuste al espacio disponible
          return Flexible(
            fit: FlexFit.tight,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: childBuilder(childIndex),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Simple connector that draws a vertical line from the top center
class SimpleCenterLineConnector extends CustomPainter {
  final Color color;

  SimpleCenterLineConnector({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final centerX = size.width / 2;
    canvas.drawLine(Offset(centerX, 0), Offset(centerX, size.height), paint);
  }

  @override
  bool shouldRepaint(SimpleCenterLineConnector oldDelegate) => oldDelegate.color != color;
}

/// Connector that draws a horizontal line with vertical drops for each child
class HorizontalRowConnector extends CustomPainter {
  final int childCount;
  final Color color;

  HorizontalRowConnector({required this.childCount, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (childCount == 0) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final centerX = size.width / 2;
    final topY = 0.0;
    final midY = size.height / 2;
    final bottomY = size.height;

    // Draw vertical line from top to middle if not first row
    canvas.drawLine(Offset(centerX, topY), Offset(centerX, midY), paint);

    // Draw horizontal line
    if (childCount > 1) {
      final firstChildX = size.width / (childCount * 2);
      final lastChildX = size.width - firstChildX;
      canvas.drawLine(Offset(firstChildX, midY), Offset(lastChildX, midY), paint);
    }

    // Draw vertical lines down to each child
    for (int i = 0; i < childCount; i++) {
      final childX = (i + 0.5) * size.width / childCount;
      canvas.drawLine(Offset(childX, midY), Offset(childX, bottomY), paint);
    }
  }

  @override
  bool shouldRepaint(HorizontalRowConnector oldDelegate) =>
      oldDelegate.childCount != childCount || oldDelegate.color != color;
}