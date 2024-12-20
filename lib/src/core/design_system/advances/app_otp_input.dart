import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/app_font.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';
import 'package:rh_host/src/core/design_system/base/size.dart';

class AppOTPInput extends StatefulWidget {
  const AppOTPInput({
    required this.length,
    required this.onCompleted,
    this.spacing = 8.0,
    this.disabled = false,
    this.error,
    super.key,
  });

  final int length;
  final ValueChanged<String> onCompleted;
  final double spacing;
  final bool disabled;
  final String? error;

  @override
  State<AppOTPInput> createState() => _AppOTPInputState();
}

class _AppOTPInputState extends State<AppOTPInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.length,
      (_) => TextEditingController(),
    );
    _focusNodes = List.generate(
      widget.length,
      (_) => FocusNode(),
    );
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }

    final otp = _controllers.map((c) => c.text).join();
    if (otp.length == widget.length) {
      widget.onCompleted(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(widget.length, (index) {
            return SizedBox(
              width: 48,
              child: TextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                enabled: !widget.disabled,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                decoration: InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSize.radiusSM),
                  ),
                ),
                onChanged: (value) => _onChanged(value, index),
              ),
            );
          }),
        ),
        if (widget.error != null) ...[
          SizedBox(height: Spacing.xxs),
          Text(
            widget.error!,
            style: AppFonts.labelSmall.copyWith(
              color: AppColors.error,
            ),
          ),
        ],
      ],
    );
  }
}
