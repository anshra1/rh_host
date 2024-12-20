import 'package:flutter/material.dart';

class AppTab extends StatelessWidget {
  const AppTab({
    required this.label,
    this.icon,
    super.key,
  });

  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return Tab(
        icon: Icon(icon),
        text: label,
      );
    }
    return Tab(text: label);
  }
}
