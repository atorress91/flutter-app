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
      onRefresh: widget.onRefresh,
      builder: (context, child, controller) {
        // Controla la animación basándose en el estado del controller
        if (controller.isArmed || controller.isLoading) {
          if (!_animationController.isAnimating) {
            _animationController.repeat();
          }
        } else {
          if (_animationController.isAnimating) {
            _animationController.stop();
          }
        }

        return Stack(
          clipBehavior: Clip.none,
          children: [
            child,
            if (controller.isArmed || controller.isLoading)
              Positioned(
                top: 60.0 * controller.value,
                left: 0,
                right: 0,
                child: Center(
                  child: RotationTransition(
                    turns: _animationController,
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
