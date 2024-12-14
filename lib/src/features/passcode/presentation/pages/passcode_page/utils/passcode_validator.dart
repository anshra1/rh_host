// Project imports:
import 'package:rh_host/src/core/constants/string.dart';
import 'package:rh_host/src/core/utils/pattern/pattern.dart';
import 'package:rh_host/src/core/utils/validator/field_validator.dart';
import 'package:rh_host/src/core/utils/validator/validation_result.dart';

class PasscodeValidator {

  // Private constructor to prevent instantiation
  const PasscodeValidator._();
  static const int _passcodeLength = 4;

  static String? _baseValidation(
    String? value, {
    required String fieldName,
    String? customRequiredMessage,
  }) {
    final validationResult = FieldValidator.validate(
      value,
      maxLength: _passcodeLength,
      minLength: _passcodeLength,
      pattern: Patterns.numericOnly,
      minLengthMessage: '$fieldName must be $_passcodeLength digits',
      patternMessage: 'Only numbers are allowed',
      requiredMessage: customRequiredMessage ?? 'Please enter $fieldName',
    );

    return validationResult == ValidationResult.success()
        ? null
        : validationResult.toString();
  }

  static String? validatePasscode(String? value) {
    return _baseValidation(value, fieldName: 'Passcode');
  }

  static String? validateConfirmPasscode(
    String? confirmPasscode,
    String newPasscode,
  ) {
    final baseValidation = _baseValidation(
      confirmPasscode,
      fieldName: 'Confirm Passcode',
      customRequiredMessage: Strings.newAndConfirmPasscodeNoMatch,
    );

    if (baseValidation != null) return baseValidation;

    return confirmPasscode != newPasscode ? Strings.newAndConfirmPasscodeNoMatch : null;
  }

  static String? validateMasterPasscode(String? value) {
    return _baseValidation(value, fieldName: 'Master Passcode');
  }
}
