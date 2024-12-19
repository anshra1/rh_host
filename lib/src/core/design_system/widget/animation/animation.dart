// Flutter imports:
import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/motion.dart';

class AppAnimationController extends StatefulWidget {
  const AppAnimationController({
    required this.child,
    this.duration = MotionTokens.durationMD,
    this.curve = MotionTokens.standard,
    super.key,
  });

  final Widget child;
  final Duration duration;
  final Curve curve;

  @override
  State<AppAnimationController> createState() => _AppAnimationControllerState();
}

class _AppAnimationControllerState extends State<AppAnimationController>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => Opacity(
        opacity: _animation.value,
        child: child,
      ),
      child: widget.child,
    );
  }
}

// lib/src/design/utils/animations/app_animated_switcher.dart
class AppAnimatedSwitcher extends StatelessWidget {
  const AppAnimatedSwitcher({
    required this.child,
    this.duration = MotionTokens.durationMD,
    this.switchInCurve = MotionTokens.standardDecelerate,
    this.switchOutCurve = MotionTokens.standardAccelerate,
    super.key,
  });

  final Widget child;
  final Duration duration;
  final Curve switchInCurve;
  final Curve switchOutCurve;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: switchInCurve,
      switchOutCurve: switchOutCurve,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

// lib/src/design/utils/animations/app_animated_list.dart
class AppAnimatedList extends StatelessWidget {
  const AppAnimatedList({
    required this.children,
    this.staggerDuration = const Duration(milliseconds: 50),
    this.itemDuration = MotionTokens.durationMD,
    this.curve = MotionTokens.standardDecelerate,
    super.key,
  });

  final List<Widget> children;
  final Duration staggerDuration;
  final Duration itemDuration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: children.length,
      itemBuilder: (context, index) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: itemDuration,
          curve: curve,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );
          },
          child: children[index],
        );
      },
    );
  }
}
