// Package imports:
import 'package:equatable/equatable.dart';
import 'package:rh_host/src/core/utils/validator/validation_error.dart';

class ValidationResult extends Equatable {
  const ValidationResult._({
    required this.isValid,
    this.error,
  });

  factory ValidationResult.success() => const ValidationResult._(isValid: true);

  factory ValidationResult.error(ValidationError error) => ValidationResult._(
        isValid: false,
        error: error,
      );

  final bool isValid;
  final ValidationError? error;

  @override
  String toString() {
    return error != null ? '${error?.message}' : '';
  }

  @override
  List<Object?> get props => [isValid, error];
}
