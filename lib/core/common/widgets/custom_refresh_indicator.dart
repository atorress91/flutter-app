import 'package:flutter/material.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart' as cri;

class CustomRefreshIndicator extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const CustomRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  State<CustomRefreshIndicator> createState() => _CustomRefreshIndicatorState();
}

class _CustomRefreshIndicatorState extends State<CustomRefreshIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  static const _minRefreshDuration = Duration(milliseconds: 1200);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final logoAsset = isDarkMode
        ? 'assets/images/yellow-logo.png'
        : 'assets/images/green-logo.png';

    return cri.CustomRefreshIndicator(
      onRefresh: () async {
        if (!_animationController.isAnimating) {
          _animationController.repeat();
        }
        await Future.wait([
          widget.onRefresh(),
          Future.delayed(_minRefreshDuration),
        ]);
        if (_animationController.isAnimating) {
          _animationController.stop();
        }
      },
      offsetToArmed: 100,
      builder: (context, child, controller) {
        return Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Opacity(
              opacity: 1.0 - controller.value.clamp(0.0, 1.0),
              child: child,
            ),
            Positioned(
              top: -40 + (controller.value * 80),
              left: 0,
              right: 0,
              child: Center(
                child: RotationTransition(
                  turns: controller.isLoading
                      ? _animationController
                      : AlwaysStoppedAnimation(controller.value * 2),
                  child: Image.asset(
                    logoAsset,
                    height: 40,
                  ),
                ),
              ),
            ),
          ],
        );
      },
      child: widget.child,
    );
  }
}