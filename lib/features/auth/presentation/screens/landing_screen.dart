import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  late final AnimationController _drawCtrl;
  late final AnimationController _colorCtrl;
  late final AnimationController _pulseCtrl;
  late final Animation<double> _drawT;
  late final Animation<double> _colorT;
  late final Animation<double> _pulseT;

  @override
  void initState() {
    super.initState();

    _drawCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );
    _drawT = CurvedAnimation(parent: _drawCtrl, curve: Curves.easeInOutCubic);

    _colorCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _colorT = CurvedAnimation(parent: _colorCtrl, curve: Curves.easeOut);

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _pulseT = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

    _drawCtrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) _colorCtrl.forward();
        });
      }
    });

    _colorCtrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _navigateToLogin();
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _drawCtrl.forward();
    });
  }

  void _navigateToLogin() {
    if (mounted) {
      context.pushReplacement('/auth/login');
    }
  }

  @override
  void dispose() {
    _drawCtrl.dispose();
    _colorCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // El resto del código de la UI no necesita cambios y permanece igual.
    return Scaffold(
      backgroundColor: const Color(0xFF0A0B0D),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.5,
                colors: [const Color(0xFF1A1B1F), const Color(0xFF0A0B0D)],
              ),
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([_drawT, _colorT, _pulseT]),
              builder: (context, child) {
                return Transform.scale(
                  scale: _colorT.value > 0.5 ? _pulseT.value : 1.0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 120,
                    child: CustomPaint(
                      painter: RecycoinLogoPainter(
                        drawProgress: _drawT.value,
                        colorProgress: _colorT.value,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _colorT,
              builder: (context, child) {
                return Opacity(
                  opacity: _colorT.value,
                  child: Column(
                    children: [
                      Text(
                        'Cargando...',
                        style: TextStyle(
                          color: Colors.white.withAlpha(
                            (kRadialReactionAlpha * 08).toInt(),
                          ),
                          fontSize: 14,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 120,
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.white.withAlpha(
                            (kRadialReactionAlpha * 0.1).toInt(),
                          ),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            const Color(
                              0xFFAED500,
                            ).withAlpha((kRadialReactionAlpha * 0.8).toInt()),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// La clase RecycoinLogoPainter no necesita cambios.
class RecycoinLogoPainter extends CustomPainter {
  final double drawProgress;
  final double colorProgress;

  RecycoinLogoPainter({
    required this.drawProgress,
    required this.colorProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final logoHeight = size.height;
    final iconSize = logoHeight * 0.9;
    final spacing = logoHeight * 0.15;
    final textWidth = _calculateTextWidth(logoHeight);
    final totalWidth = iconSize + spacing + textWidth;
    final startX = (size.width - totalWidth) / 2;
    _drawIcon(
      canvas,
      Offset(startX + iconSize / 2, size.height / 2),
      iconSize / 2,
    );
    _drawText(
      canvas,
      Offset(startX + iconSize + spacing, size.height / 2),
      logoHeight,
    );
  }

  void _drawIcon(Canvas canvas, Offset center, double radius) {
    final greenColor = Color.lerp(
      Colors.white,
      const Color(0xFFAED500),
      colorProgress,
    )!;
    final circlePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.15
      ..color = greenColor
      ..strokeCap = StrokeCap.round;
    final circlePath = Path();
    final circleRect = Rect.fromCircle(center: center, radius: radius * 0.85);
    circlePath.addArc(circleRect, -math.pi / 2, math.pi * 2 * drawProgress);
    canvas.drawPath(circlePath, circlePaint);
    if (drawProgress > 0.3) {
      final leafProgress = ((drawProgress - 0.3) / 0.7).clamp(0.0, 1.0);
      _drawLeaf(canvas, center, radius * 0.6, leafProgress, greenColor);
    }
  }

  void _drawLeaf(
      Canvas canvas,
      Offset center,
      double size,
      double progress,
      Color color,
      ) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size * 0.08
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final path = Path();
    final trunkStart = Offset(center.dx, center.dy + size * 0.4);
    final trunkEnd = Offset(center.dx, center.dy - size * 0.1);
    if (progress > 0) {
      final currentTrunk = Offset.lerp(
        trunkStart,
        trunkEnd,
        progress.clamp(0.0, 0.3) / 0.3,
      )!;
      path.moveTo(trunkStart.dx, trunkStart.dy);
      path.lineTo(currentTrunk.dx, currentTrunk.dy);
    }
    if (progress > 0.3) {
      final branchProgress = ((progress - 0.3) / 0.7).clamp(0.0, 1.0);
      final leftStart = Offset(center.dx, center.dy + size * 0.2);
      final leftEnd = Offset(center.dx - size * 0.3, center.dy);
      final currentLeft = Offset.lerp(leftStart, leftEnd, branchProgress)!;
      path.moveTo(leftStart.dx, leftStart.dy);
      path.lineTo(currentLeft.dx, currentLeft.dy);
      final rightStart = Offset(center.dx, center.dy + size * 0.2);
      final rightEnd = Offset(center.dx + size * 0.3, center.dy);
      final currentRight = Offset.lerp(rightStart, rightEnd, branchProgress)!;
      path.moveTo(rightStart.dx, rightStart.dy);
      path.lineTo(currentRight.dx, currentRight.dy);
      if (branchProgress > 0.5) {
        final upperProgress = ((branchProgress - 0.5) / 0.5).clamp(0.0, 1.0);
        final leftUpperStart = Offset(center.dx, center.dy - size * 0.05);
        final leftUpperEnd = Offset(
          center.dx - size * 0.25,
          center.dy - size * 0.3,
        );
        final currentLeftUpper = Offset.lerp(
          leftUpperStart,
          leftUpperEnd,
          upperProgress,
        )!;
        path.moveTo(leftUpperStart.dx, leftUpperStart.dy);
        path.lineTo(currentLeftUpper.dx, currentLeftUpper.dy);
        final rightUpperStart = Offset(center.dx, center.dy - size * 0.05);
        final rightUpperEnd = Offset(
          center.dx + size * 0.25,
          center.dy - size * 0.3,
        );
        final currentRightUpper = Offset.lerp(
          rightUpperStart,
          rightUpperEnd,
          upperProgress,
        )!;
        path.moveTo(rightUpperStart.dx, rightUpperStart.dy);
        path.lineTo(currentRightUpper.dx, currentRightUpper.dy);
      }
    }
    canvas.drawPath(path, paint);
  }

  void _drawText(Canvas canvas, Offset position, double height) {
    final text = 'Recycoin';
    final fontSize = height * 0.7;
    final textColor = Color.lerp(
      Colors.white,
      const Color(0xFFAED500),
      colorProgress,
    )!;
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: textColor,
          letterSpacing: -1,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    if (drawProgress > 0.5) {
      final textProgress = ((drawProgress - 0.5) / 0.5).clamp(0.0, 1.0);
      final visibleChars = (text.length * textProgress).round();
      if (visibleChars > 0) {
        final visibleText = text.substring(0, visibleChars);
        final visiblePainter = TextPainter(
          text: TextSpan(
            text: visibleText,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: textColor,
              letterSpacing: -1,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        visiblePainter.layout();
        visiblePainter.paint(
          canvas,
          Offset(position.dx, position.dy - visiblePainter.height / 2),
        );
      }
    }
  }

  double _calculateTextWidth(double height) {
    final fontSize = height * 0.7;
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Recycoin',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          letterSpacing: -1,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    return textPainter.width;
  }

  @override
  bool shouldRepaint(RecycoinLogoPainter oldDelegate) {
    return oldDelegate.drawProgress != drawProgress ||
        oldDelegate.colorProgress != colorProgress;
  }
}