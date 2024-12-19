// Project imports:
import 'package:rh_host/src/core/utils/validator/validation_error.dart';
import 'package:rh_host/src/core/utils/validator/validation_result.dart';

// ignore: one_member_abstracts
abstract class ValidationRule {
  ValidationResult validate(String value);
}

// Example custom rules:
class PasswordStrengthRule extends ValidationRule {
  @override
  ValidationResult validate(String value) {
    if (!RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$&*~]).{8,}$')
        .hasMatch(value)) {
      return ValidationResult.error(
        const ValidationError(
          message:
              'Password must contain uppercase, number, and special character',
          code: 'weak_password',
        ),
      );
    }
    return ValidationResult.success();
  }
}
