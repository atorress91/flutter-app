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
  late final AnimationController _particlesCtrl;
  late final AnimationController _backgroundCtrl;
  late final AnimationController _slideCtrl;
  late final Animation<double> _drawT;
  late final Animation<double> _colorT;
  late final Animation<double> _pulseT;
  late final Animation<double> _particlesT;
  late final Animation<double> _backgroundT;
  late final Animation<Offset> _slideT;

  final List<Particle> _particles = [];
  final List<FloatingIcon> _floatingIcons = [];

  @override
  void initState() {
    super.initState();

    _initAnimations();
    _generateParticles();
    _generateFloatingIcons();
    _startAnimationSequence();
  }

  void _initAnimations() {
    _drawCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );
    _drawT = CurvedAnimation(parent: _drawCtrl, curve: Curves.easeInOutCubic);

    _colorCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _colorT = CurvedAnimation(parent: _colorCtrl, curve: Curves.easeOutBack);

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _pulseT = Tween<double>(
      begin: 0.95,
      end: 1.08,
    ).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

    _particlesCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
    _particlesT = Tween<double>(begin: 0, end: 1).animate(_particlesCtrl);

    _backgroundCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
    _backgroundT = Tween<double>(begin: 0, end: 1).animate(_backgroundCtrl);

    _slideCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _slideT = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOutBack));

    _drawCtrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) _colorCtrl.forward();
        });
      }
    });

    _colorCtrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 1500), () {
          _navigateToLogin();
        });
      }
    });
  }

  void _generateParticles() {
    final random = math.Random();
    for (int i = 0; i < 50; i++) {
      _particles.add(Particle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: random.nextDouble() * 3 + 1,
        speed: random.nextDouble() * 0.5 + 0.1,
        opacity: random.nextDouble() * 0.6 + 0.2,
      ));
    }
  }

  void _generateFloatingIcons() {
    final random = math.Random();
    final icons = [Icons.recycling, Icons.eco, Icons.nature, Icons.energy_savings_leaf];

    for (int i = 0; i < 8; i++) {
      _floatingIcons.add(FloatingIcon(
        icon: icons[random.nextInt(icons.length)],
        x: random.nextDouble(),
        y: random.nextDouble(),
        rotation: random.nextDouble() * math.pi * 2,
        rotationSpeed: (random.nextDouble() - 0.5) * 0.02,
        floatSpeed: random.nextDouble() * 0.3 + 0.1,
        size: random.nextDouble() * 20 + 15,
        opacity: random.nextDouble() * 0.3 + 0.1,
      ));
    }
  }

  void _startAnimationSequence() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _drawCtrl.forward();
        _slideCtrl.forward();
      }
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
    _particlesCtrl.dispose();
    _backgroundCtrl.dispose();
    _slideCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0B0D),
      body: Stack(
        children: [
          // Fondo animado con gradientes dinámicos
          AnimatedBuilder(
            animation: _backgroundT,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 2.0 + math.sin(_backgroundT.value * math.pi * 2) * 0.5,
                    colors: [
                      Color.lerp(
                        const Color(0xFF1A1B1F),
                        const Color(0xFF2D4A22),
                        math.sin(_backgroundT.value * math.pi * 2) * 0.3 + 0.3,
                      )!,
                      const Color(0xFF0A0B0D),
                      Color.lerp(
                        const Color(0xFF0A0B0D),
                        const Color(0xFF1A2B1A),
                        math.cos(_backgroundT.value * math.pi * 2) * 0.2 + 0.2,
                      )!,
                    ],
                  ),
                ),
              );
            },
          ),

          // Partículas flotantes
          AnimatedBuilder(
            animation: _particlesT,
            builder: (context, child) {
              return CustomPaint(
                size: Size.infinite,
                painter: ParticlesPainter(
                  particles: _particles,
                  progress: _particlesT.value,
                ),
              );
            },
          ),

          // Iconos flotantes
          AnimatedBuilder(
            animation: _particlesT,
            builder: (context, child) {
              return CustomPaint(
                size: Size.infinite,
                painter: FloatingIconsPainter(
                  icons: _floatingIcons,
                  progress: _particlesT.value,
                ),
              );
            },
          ),

          Center(
            child: SlideTransition(
              position: _slideT,
              child: AnimatedBuilder(
                animation: Listenable.merge([_drawT, _colorT, _pulseT]),
                builder: (context, child) {
                  return Transform.scale(
                    scale: _colorT.value > 0.5 ? _pulseT.value : 1.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: _colorT.value > 0.3
                            ? [
                                BoxShadow(
                                  color: Color.fromARGB(
                                    (76 * _colorT.value.clamp(0.0, 1.0)).round(),
                                    174, 213, 0
                                  ),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                ),
                                BoxShadow(
                                  color: Color.fromARGB(
                                    (25 * _colorT.value.clamp(0.0, 1.0)).round(),
                                    174, 213, 0
                                  ),
                                  blurRadius: 60,
                                  spreadRadius: 10,
                                ),
                              ]
                            : null,
                      ),
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
          ),

          // Texto de carga mejorado con efectos
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _slideCtrl,
                curve: const Interval(0.3, 1.0, curve: Curves.easeOutBack),
              )),
              child: AnimatedBuilder(
                animation: _colorT,
                builder: (context, child) {
                  return Opacity(
                    opacity: _colorT.value.clamp(0.0, 1.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Color.fromARGB(
                                (76 * _colorT.value.clamp(0.0, 1.0)).round(),
                                174, 213, 0
                              ),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(
                                  (25 * _colorT.value.clamp(0.0, 1.0)).round(),
                                  174, 213, 0
                                ),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Text(
                            'Iniciando ...',
                            style: TextStyle(
                              color: Color.fromARGB(
                                (230 * _colorT.value.clamp(0.0, 1.0)).round(),
                                255, 255, 255
                              ),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: 200,
                          height: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Color.fromARGB(
                              (25 * _colorT.value.clamp(0.0, 1.0)).round(),
                              255, 255, 255
                            ),
                          ),
                          child: AnimatedBuilder(
                            animation: _drawT,
                            builder: (context, child) {
                              return Container(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 200 * _drawT.value.clamp(0.0, 1.0),
                                  height: 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFAED500),
                                        Color(0xFF7CB342),
                                        Color(0xFFAED500),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromARGB(
                                          (127 * _drawT.value.clamp(0.0, 1.0)).round(),
                                          174, 213, 0
                                        ),
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // Mensaje ambiental inspirador
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _colorT,
              builder: (context, child) {
                return Opacity(
                  opacity: ((_colorT.value * 2 - 1).clamp(0.0, 1.0)),
                  child: Text(
                    '🌱 Riqueza Inteligente, Planeta Sostenible 🌍, Ganamos juntos',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(
                        (178 * ((_colorT.value * 2 - 1).clamp(0.0, 1.0))).round(),
                        255, 255, 255
                      ),
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 0.3,
                    ),
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

// Clase para partículas flotantes
class Particle {
  double x, y, size, speed, opacity;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
  });
}

// Clase para iconos flotantes
class FloatingIcon {
  final IconData icon;
  double x, y, rotation, rotationSpeed, floatSpeed, size, opacity;

  FloatingIcon({
    required this.icon,
    required this.x,
    required this.y,
    required this.rotation,
    required this.rotationSpeed,
    required this.floatSpeed,
    required this.size,
    required this.opacity,
  });
}

// Painter para partículas
class ParticlesPainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;

  ParticlesPainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final particle in particles) {
      final currentY = (particle.y + progress * particle.speed) % 1.0;
      final opacity = particle.opacity * math.sin(progress * math.pi * 2 + particle.x * 10);
      final safeOpacity = (opacity.abs() * 0.6).clamp(0.0, 1.0);

      paint.color = Color.fromARGB(
        (255 * safeOpacity).round(),
        174, 213, 0
      );

      canvas.drawCircle(
        Offset(particle.x * size.width, currentY * size.height),
        particle.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(ParticlesPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// Painter para iconos flotantes
class FloatingIconsPainter extends CustomPainter {
  final List<FloatingIcon> icons;
  final double progress;

  FloatingIconsPainter({required this.icons, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final floatingIcon in icons) {
      final currentY = (floatingIcon.y + progress * floatingIcon.floatSpeed) % 1.2 - 0.1;
      final currentRotation = floatingIcon.rotation + progress * floatingIcon.rotationSpeed * 10;

      if (currentY >= 0 && currentY <= 1) {
        canvas.save();
        canvas.translate(
          floatingIcon.x * size.width,
          currentY * size.height,
        );
        canvas.rotate(currentRotation);

        final safeOpacity = floatingIcon.opacity.clamp(0.0, 1.0);
        final textPainter = TextPainter(
          text: TextSpan(
            text: String.fromCharCode(floatingIcon.icon.codePoint),
            style: TextStyle(
              fontFamily: floatingIcon.icon.fontFamily,
              fontSize: floatingIcon.size,
              color: Color.fromARGB(
                (255 * safeOpacity).round(),
                174, 213, 0
              ),
            ),
          ),
          textDirection: TextDirection.ltr,
        );

        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(-textPainter.width / 2, -textPainter.height / 2),
        );

        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(FloatingIconsPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// Painter del logo Recycoin
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
    final iconSize = logoHeight * 0.7; // Reducido de 0.9 a 0.7
    final spacing = logoHeight * 0.1; // Reducido de 0.15 a 0.1
    final textWidth = _calculateTextWidth(logoHeight);
    final totalWidth = iconSize + spacing + textWidth;
    final startX = (size.width - totalWidth) / 2;

    // Efecto de brillo detrás del logo
    if (colorProgress > 0.5) {
      final glowPaint = Paint()
        ..style = PaintingStyle.fill
        ..shader = RadialGradient(
          colors: [
            Color.fromARGB(76, 174, 213, 0), // Usando Color.fromARGB para evitar deprecación
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(
          center: Offset(startX + iconSize / 2, size.height / 2),
          radius: iconSize * 0.8,
        ));

      canvas.drawCircle(
        Offset(startX + iconSize / 2, size.height / 2),
        iconSize * 0.8,
        glowPaint,
      );
    }

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
