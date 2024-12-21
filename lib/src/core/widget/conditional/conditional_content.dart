import 'package:flutter/material.dart';

class ConditionalContent extends StatelessWidget {
  const ConditionalContent({
    required this.show,
    required this.child,
    this.fallback = const SizedBox.shrink(),
    super.key,
  });

  final bool show;
  final Widget child;
  final Widget fallback;

  @override
  Widget build(BuildContext context) => show ? child : fallback;
}
