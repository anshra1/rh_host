import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/app_font.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';

class AppSlider extends StatelessWidget {
  const AppSlider({
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.disabled = false,
    super.key,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppFonts.labelMedium,
          ),
          SizedBox(height: Spacing.xxs),
        ],
        SliderTheme(
          data: const SliderThemeData(
            trackHeight: 4,
            thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: 6,
            ),
          ),
          child: Slider(
            value: value,
            onChanged: disabled ? null : onChanged,
            min: min,
            max: max,
            divisions: divisions,
            label: value.toString(),
          ),
        ),
      ],
    );
  }
}
