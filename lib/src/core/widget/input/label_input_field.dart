import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rh_host/src/core/widget/input/app_text_field.dart';

class LabelTextField extends StatelessWidget {
  const LabelTextField({
    required this.controller,
    required this.title,
    this.required = true,
    this.hintText,
    this.hintStyle,
    this.suffixIcon,
    this.maxLength,
    this.keyboardType,
    this.errorStyle,
    this.validator,
    this.fieldRequirement = FieldRequirement.none,
    this.inputFormatters,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
    this.autofocus = false,
    super.key,
  });

  final FieldRequirement fieldRequirement;
  final bool required;
  final TextEditingController controller;
  final String title;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextStyle? errorStyle;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                  children: [fieldRequirement.marker],
                ),
              ),
            ),
            if (suffixIcon != null) suffixIcon!,
          ],
        ),
        const SizedBox(height: 10),
        AppTextField(
          inputFormatters: inputFormatters,
          focusNode: focusNode,
          controller: controller,
          hint: hintText ?? '',
          hintStyle: hintStyle,
          filled: false,
          keyboardType: keyboardType,
          maxLength: maxLength,
          errorStyle: errorStyle,
          overrideValidator: true,
          autofocus: autofocus,
          textInputAction: textInputAction,
          onSubmitted: onFieldSubmitted,
          onEditingComplete: () {
            if (textInputAction == TextInputAction.next) {
              FocusScope.of(context).nextFocus();
            } else if (textInputAction == TextInputAction.done) {
              FocusScope.of(context).unfocus();
            }
          },
          validator: validator ??
              (value) {
                if (!required) return null;
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
        ),
      ],
    );
  }
}

// Enhanced field requirement enum with more semantic naming
enum FieldRequirement {
  required('*', Colors.red),
  optional('(Optional)', Colors.grey),
  none('', Colors.transparent);

  const FieldRequirement(this.symbol, this.color);

  final String symbol;
  final Color color;

  TextSpan get marker {
    if (this == FieldRequirement.none) return const TextSpan();

    return TextSpan(
      text: ' $symbol',
      style: TextStyle(
        color: color,
        fontSize: this == FieldRequirement.optional ? 14 : 16,
        fontWeight:
            this == FieldRequirement.optional ? FontWeight.normal : FontWeight.w400,
      ),
    );
  }
}
