// Flutter imports:
import 'package:flutter/services.dart';

class AppInputFormatters {
  const AppInputFormatters._();

  /// Formatter for passcode input
  static List<TextInputFormatter> get passcode => [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
        _PasscodeInputFormatter(),
      ];

  /// Formatter for phone numbers
  static List<TextInputFormatter> get phoneNumber => [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
        _PhoneNumberFormatter(),
      ];

  /// Formatter for currency input
  static List<TextInputFormatter> get currency => [
        FilteringTextInputFormatter.digitsOnly,
        _CurrencyInputFormatter(),
      ];

  /// Formatter for names (letters only)
  static List<TextInputFormatter> get name => [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
        _CapitalizeWordsFormatter(),
      ];

  /// Formatter for email addresses
  static List<TextInputFormatter> get email => [
        FilteringTextInputFormatter.deny(RegExp(r'\s')), // No whitespace
        _EmailInputFormatter(),
      ];

  //       static TextInputFormatter get phoneNumber {
  //   return FilteringTextInputFormatter.allow(RegExp(r'[\d-+() ]'));
  // }

  static TextInputFormatter get digitsOnly {
    return FilteringTextInputFormatter.allow(RegExp(r'\d'));
  }

  static TextInputFormatter get noEmoji {
    return FilteringTextInputFormatter.deny(
      RegExp(r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
    );
  }

  static TextInputFormatter maxLength(int length) {
    return LengthLimitingTextInputFormatter(length);
  }

  static TextInputFormatter customPattern(Pattern pattern) {
    return FilteringTextInputFormatter.allow(pattern);
  }
}


/// Custom formatter for passcode input
class _PasscodeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Prevent paste operations
    if (newValue.text.length - oldValue.text.length > 1) {
      return oldValue;
    }

    final filtered = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    final truncated = filtered.length > 4 ? filtered.substring(0, 4) : filtered;

    return TextEditingValue(
      text: truncated,
      selection: TextSelection.collapsed(offset: truncated.length),
    );
  }
}

/// Custom formatter for phone numbers (XXX-XXX-XXXX)
class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final numbers = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    if (numbers.isEmpty) return newValue.copyWith(text: '');

    final formatted = StringBuffer();
    for (var i = 0; i < numbers.length; i++) {
      if (i == 3 || i == 6) formatted.write('-');
      formatted.write(numbers[i]);
    }

    return TextEditingValue(
      text: formatted.toString(),
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Custom formatter for currency input
class _CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    final number = int.tryParse(newValue.text) ?? 0;
    final formatted = '\$${number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
        )}';

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Custom formatter to capitalize words
class _CapitalizeWordsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    final words = newValue.text.split(' ');
    final capitalized = words.map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');

    return TextEditingValue(
      text: capitalized,
      selection: TextSelection.collapsed(offset: capitalized.length),
    );
  }
}

/// Custom formatter for email input
class _EmailInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.toLowerCase();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
