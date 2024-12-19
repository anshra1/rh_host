// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.controller,
    super.key,
    this.validator,
    this.filled = false,
    this.fillColor,
    this.obsecureText = false,
    this.readOnly = false,
    this.suffixIcon,
    this.hintText,
    this.keyboardType,
    this.overrideValidator = false,
    this.style,
    this.focusNode,
    this.errorStyle,
    this.contentPadding,
    this.inputFormatters,
    this.maxLength,
    this.maxLines,
    this.requiredErrorMessage = 'This Field is required',
    this.errorBorder,
    this.disabledBorder,
    this.isMaxLength = false,
  });

  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool filled;
  final Color? fillColor;
  final bool obsecureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool overrideValidator;
  final TextStyle? style;
  final FocusNode? focusNode;
  final TextStyle? errorStyle;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? maxLines;
  final String requiredErrorMessage;
  final OutlineInputBorder? errorBorder;
  final OutlineInputBorder? disabledBorder;
  final bool isMaxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      validator: overrideValidator
          ? validator
          : (value) {
              if (value == null || value.isEmpty) {
                return requiredErrorMessage;
              }
              return validator?.call(value);
            },
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      obscureText: obsecureText,
      readOnly: readOnly,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLength: !isMaxLength ? null : maxLength,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        errorBorder: errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
        disabledBorder: disabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
        contentPadding:
            contentPadding ?? const EdgeInsets.symmetric(horizontal: 50),
        filled: filled,
        fillColor: fillColor,
        suffixIcon: suffixIcon,
        hintText: hintText ?? '',
        hintStyle: style ??
            const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
        errorStyle: errorStyle ?? const TextStyle(color: Colors.red),
      ),
    );
  }
}
