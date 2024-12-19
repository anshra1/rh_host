// Project imports:
import 'package:rh_host/src/core/utils/validator/custom_rule.dart';
import 'package:rh_host/src/core/utils/validator/validation_error.dart';
import 'package:rh_host/src/core/utils/validator/validation_result.dart';

class FieldValidator {
  const FieldValidator._();

  static ValidationResult validate(
    String? value, {
    bool isRequired = true,
    int? maxLength,
    int? minLength,
    Pattern? pattern,
    String? fieldName,
    String? requiredMessage,
    String? minLengthMessage,
    String? maxLengthMessage,
    String? patternMessage,
    List<ValidationRule> additionalRules = const [],
  }) {
    // Early return for optional fields
    if (!isRequired && (value == null || value.isEmpty)) {
      return ValidationResult.success();
    }

    // Required check
    if (isRequired && (value == null || value.isEmpty)) {
      return ValidationResult.error(
        ValidationError.required(
            fieldName: fieldName, message: requiredMessage,),
      );
    }

    // Length checks
    if (minLength != null && value!.length < minLength) {
      return ValidationResult.error(
        ValidationError.minLength(
          minLength: minLength,
          fieldName: fieldName,
          message: minLengthMessage,
        ),
      );
    }

    if (maxLength != null && value!.length > maxLength) {
      return ValidationResult.error(
        ValidationError.maxLength(
          maxLength: maxLength,
          fieldName: fieldName,
          message: maxLengthMessage,
        ),
      );
    }

    // Pattern check
    if (pattern != null && !pattern.allMatches(value!).isNotEmpty) {
      return ValidationResult.error(
        ValidationError.pattern(fieldName: fieldName, message: patternMessage),
      );
    }

    // Additional rules
    for (final rule in additionalRules) {
      final result = rule.validate(value!);
      if (!result.isValid) {
        return result;
      }
    }

    return ValidationResult.success();
  }

  // static String? validateField(
  //   String? value, {
  //   bool isRequired = true,
  //   int? maxLength,
  //   int? minLength,
  //   Pattern? pattern,
  //   String? fieldName,
  //   List<ValidationRule> additionalRules = const [],
  // }) {
  //   final result = validate(
  //     value,
  //     isRequired: isRequired,
  //     maxLength: maxLength,
  //     minLength: minLength,
  //     pattern: pattern,
  //     fieldName: fieldName,
  //     additionalRules: additionalRules,
  //   );

  //   return result.isValid ? null : result.error?.message;
  // }
}

// ignore: one_member_abstracts

// Usage with passcode:
// lib/src/core/validators/passcode_validator.dart

// Example usage:
// class PasscodePage extends StatelessWidget {
//   const PasscodePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       child: Column(
//         children: [
//           TextFormField(
//             validator: PasscodeValidator.validatePasscode,
//             inputFormatters: AppInputFormatters.passcode,
//           ),
//           TextFormField(
//             validator: (value) => FieldValidator.validateField(
//               value,
//               fieldName: 'email',
//               pattern: RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'),
//             ),
//           ),
//           TextFormField(
//             validator: (value) => FieldValidator.validateField(
//               value,
//               fieldName: 'password',
//               minLength: 8,
//               additionalRules: [PasswordStrengthRule()],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
