class FormValidators {
  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) return null;

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? minLength(String? value, int minLength) {
    if (value == null || value.isEmpty) return null;

    if (value.length < minLength) {
      return 'Must be at least $minLength characters';
    }
    return null;
  }

  static String? maxLength(String? value, int maxLength) {
    if (value == null || value.isEmpty) return null;

    if (value.length > maxLength) {
      return 'Must be no more than $maxLength characters';
    }
    return null;
  }

  static String? numeric(String? value) {
    if (value == null || value.isEmpty) return null;

    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Must contain only numbers';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) return null;

    final phoneRegex = RegExp(r'^\+?[\d\s-]{10,}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? combine(List<String? Function(String?)> validators) {
    return (String? value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) return error;
      }
      return null;
    };
  }
}
