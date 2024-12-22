import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextFieldVariant { outlined, underlined, none }

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.controller,
    super.key,
    this.variant = TextFieldVariant.outlined,
    this.validator,
    this.filled = true,
    this.fillColor,
    this.obscureText = false,
    this.readOnly = false,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.hint,
    this.keyboardType,
    this.overrideValidator = false,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.focusNode,
    this.errorStyle,
    this.padding = const EdgeInsets.all(12),
    this.inputFormatters,
    this.maxLength,
    this.minLines,
    this.maxLines = 1,
    this.requiredErrorMessage = 'This Field is required',
    this.customBorder,
    this.borderRadius = 8.0,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.borderWidth = 1.0,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.textInputAction,
    this.enabled = true,
    this.autofocus = false,
    this.autocorrect = true,
    this.showCounter = false,
    this.showCursor,
    this.cursorColor,
    this.textAlign = TextAlign.start,
    this.onEditingComplete,
    this.textCapitalization = TextCapitalization.none,
  });

  final TextEditingController controller;
  final TextFieldVariant variant;
  final String? Function(String?)? validator;
  final bool filled;
  final Color? fillColor;
  final bool obscureText;
  final bool readOnly;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? label;
  final String? hint;
  final TextInputType? keyboardType;
  final bool overrideValidator;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final FocusNode? focusNode;
  final TextStyle? errorStyle;
  final EdgeInsetsGeometry padding;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? minLines;
  final int maxLines;
  final String requiredErrorMessage;
  final InputBorder? customBorder;
  final double borderRadius;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final double borderWidth;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final TextInputAction? textInputAction;
  final bool enabled;
  final bool autofocus;
  final bool autocorrect;
  final bool showCounter;
  final bool? showCursor;
  final Color? cursorColor;
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      validator: validator ?? _buildValidator(),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      obscureText: obscureText,
      readOnly: readOnly,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      textInputAction: textInputAction,
      enabled: enabled,
      autofocus: autofocus,
      autocorrect: autocorrect,
      showCursor: showCursor,
      cursorColor: cursorColor ?? colorScheme.primary,
      textAlign: textAlign,
      textCapitalization: textCapitalization,
      style:
          textStyle ?? theme.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
      decoration: _buildDecoration(context),
      onEditingComplete: onEditingComplete,
    );
  }

  String? Function(String?)? _buildValidator() {
    if (overrideValidator) return validator;
    return (value) {
      if (value == null || value.isEmpty) {
        return requiredErrorMessage;
      }
      return validator?.call(value);
    };
  }

  InputDecoration _buildDecoration(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InputDecoration(
      border: _buildBorder(),
      enabledBorder: _buildBorder(
        color: borderColor ?? colorScheme.outline,
      ),
      focusedBorder: _buildBorder(
        color: focusedBorderColor ?? colorScheme.primary,
        width: 2,
      ),
      errorBorder: _buildBorder(
        color: errorBorderColor ?? colorScheme.error,
      ),
      disabledBorder: _buildBorder(
        color: colorScheme.onSurface.withAlpha((0.38 * 255).toInt()),
      ),
      filled: filled,
      fillColor: fillColor ?? colorScheme.surfaceContainerHighest,
      contentPadding: padding,
      prefix: prefix,
      suffix: suffix,
      prefixIcon: prefixIcon != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: prefixIcon,
            )
          : null,
      suffixIcon: suffixIcon != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: suffixIcon,
            )
          : null,
      labelText: label,
      hintText: hint,
      counterText: showCounter ? null : '',
      labelStyle: labelStyle ??
          theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
      hintStyle: hintStyle ??
          theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant.withAlpha((0.75 * 255).toInt()),
          ),
      errorStyle: errorStyle ??
          TextStyle(
            color: colorScheme.error,
            fontSize: 12,
            height: 1,
          ),
      isDense: true,
    );
  }

  InputBorder _buildBorder({Color? color, double width = 1.0}) {
    if (customBorder != null) return customBorder!;

    final borderSide = BorderSide(
      color: color ?? Colors.transparent,
      width: width,
    );

    switch (variant) {
      case TextFieldVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: borderSide,
        );
      case TextFieldVariant.underlined:
        return UnderlineInputBorder(
          borderSide: borderSide,
        );
      case TextFieldVariant.none:
        return InputBorder.none;
    }
  }
}
