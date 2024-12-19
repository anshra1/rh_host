// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:equatable/equatable.dart';

class StatusAction extends Equatable {
  const StatusAction({
    required this.label,
    required this.onPressed,
    this.textColor,
    this.backgroundColor,
  });

  final String label;
  final VoidCallback onPressed;
  final Color? textColor;
  final Color? backgroundColor;

  @override
  List<Object?> get props => [label, textColor, backgroundColor];
}
