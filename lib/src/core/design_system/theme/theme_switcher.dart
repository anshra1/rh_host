import 'package:flutter/material.dart';

class AnimatedThemeSwitcher extends StatelessWidget {
  const AnimatedThemeSwitcher({
    required this.child,
    super.key,
    this.duration = const Duration(milliseconds: 300),
    this.reverseDuration,
    this.switchInCurve = Curves.easeInOut,
    this.switchOutCurve = Curves.easeInOut,
  });

  final Widget child;
  final Duration duration;
  final Duration? reverseDuration;
  final Curve switchInCurve;
  final Curve switchOutCurve;

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: Theme.of(context),
      duration: duration,
      child: AnimatedSwitcher(
        duration: duration,
        reverseDuration: reverseDuration,
        switchInCurve: switchInCurve,
        switchOutCurve: switchOutCurve,
        child: child,
      ),
    );
  }
}