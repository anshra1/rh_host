// Dart imports:
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rh_host/src/core/extension/context.dart';

extension ButtonContentExtension on AdvancedButtonContent {
  /// Creates a copy of this ButtonContent with the given fields replaced
  AdvancedButtonContent copyWith({
    String? text,
    Color? textColor,
    double? fontSize,
    bool? isLoading,
    Widget? icon,
    Widget? suffix,
    TextStyle? textStyle,
    double? minTouchSize,
    double? iconScale,
    int? maxLines,
    bool? hapticFeedbackOnTap,
  }) {
    return AdvancedButtonContent(
      text: text ?? this.text,
      textColor: textColor ?? this.textColor,
      fontSize: fontSize ?? this.fontSize,
      isLoading: isLoading ?? this.isLoading,
      icon: icon ?? this.icon,
      suffix: suffix ?? this.suffix,
      textStyle: textStyle ?? this.textStyle,
      minTouchSize: minTouchSize ?? this.minTouchSize,
      iconScale: iconScale ?? this.iconScale,
      maxLines: maxLines ?? this.maxLines,
      hapticFeedbackOnTap: hapticFeedbackOnTap ?? this.hapticFeedbackOnTap,
    );
  }
}

/// A more advanced button content widget with additional features
/// like accessibility, haptic feedback, and customization options
class AdvancedButtonContent extends StatelessWidget {
  const AdvancedButtonContent({
    required this.text,
    required this.textColor,
    required this.fontSize,
    this.isLoading = false,
    this.icon,
    this.suffix,
    this.textStyle,
    this.minTouchSize = 48.0,
    this.iconScale = 1.2,
    this.maxLines = 1,
    this.hapticFeedbackOnTap = true,
    super.key,
  })  : assert(fontSize > 0, 'fontSize must be positive'),
        assert(iconScale > 0, 'iconScale must be positive');

  final String text;
  final Color textColor;
  final double fontSize;
  final bool isLoading;
  final Widget? icon;
  final Widget? suffix;
  final TextStyle? textStyle;
  final double minTouchSize;
  final double iconScale;
  final int maxLines;
  final bool hapticFeedbackOnTap;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Semantics(
        label: 'Loading $text',
        value: 'Please wait',
        child: SizedBox(
          height: max(fontSize, minTouchSize),
          width: fontSize,
          child: Center(
            child: CircularProgressIndicator(
              color: textColor,
              strokeWidth: 2,
            ),
          ),
        ),
      );
    }

    final effectiveTextStyle = context.theme.textTheme.titleMedium?.copyWith(
      color: textColor,
      fontWeight: FontWeight.w500,
    );

    return MergeSemantics(
      child: Semantics(
        button: true,
        label: text,
        enabled: true,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTapDown: (_) {
              if (hapticFeedbackOnTap) {
                HapticFeedback.lightImpact();
              }
            },
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: minTouchSize,
                minWidth: minTouchSize,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    IconTheme(
                      data: IconThemeData(
                        size: fontSize * iconScale,
                        color: textColor,
                      ),
                      child: icon!,
                    ),
                    SizedBox(width: fontSize * 0.5),
                  ],
                  Flexible(
                    child: Text(
                      text,
                      style: textStyle ?? effectiveTextStyle,
                      maxLines: maxLines,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (suffix != null) ...[
                    SizedBox(width: fontSize * 0.5),
                    IconTheme(
                      data: IconThemeData(
                        size: fontSize * iconScale,
                        color: textColor,
                      ),
                      child: suffix!,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
