class ValidationError {
  const ValidationError({
    required this.message,
    required this.code,
  });

  factory ValidationError.required({
    String? fieldName, 
    String? message,
  }) => ValidationError(
    message: message ?? 'Please enter ${fieldName ?? 'this field'}',
    code: 'required',
  );

  factory ValidationError.minLength({
    required int minLength,
    String? fieldName,
    String? message,
  }) => ValidationError(
    message: message ?? '${fieldName ?? 'Field'} must be at least $minLength characters',
    code: 'min_length',
  );

  factory ValidationError.maxLength({
    required int maxLength,
    String? fieldName,
    String? message,
  }) => ValidationError(
    message: message ?? '${fieldName ?? 'Field'} cannot exceed $maxLength characters',
    code: 'max_length',
  );

  factory ValidationError.pattern({
    String? fieldName,
    String? message,
  }) => ValidationError(
    message: message ?? 'Invalid ${fieldName ?? 'format'}',
    code: 'invalid_pattern',
  );

  final String message;
  final String code;
}