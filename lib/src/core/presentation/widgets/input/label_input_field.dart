// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:rh_host/src/core/presentation/widgets/input/app_text_field.dart';

class TitledInputField extends StatelessWidget {
  const TitledInputField({
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Replace with your text color
                ),
                children: [fieldRequirement.marker],
              ),
            ),
            if (suffixIcon != null) suffixIcon!,
          ],
        ),
        const SizedBox(height: 10),
        AppTextField(
          inputFormatters: inputFormatters,
          controller: controller,
          hintText: hintText ?? 'Enter $title',
          style: hintStyle,
          keyboardType: keyboardType,
          maxLength: maxLength,
          errorStyle: errorStyle,
          overrideValidator: true,
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

enum FieldRequirement {
  required,
  optional,
  none;

  TextSpan get marker {
    switch (this) {
      case FieldRequirement.required:
        return const TextSpan(
          text: ' *',
          style: TextStyle(color: Colors.red),
        );
      case FieldRequirement.optional:
        return const TextSpan(
          text: ' (Optional)',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        );
      case FieldRequirement.none:
        return const TextSpan();
    }
  }
}
