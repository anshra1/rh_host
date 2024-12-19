class InputValidators {
  static bool isEmail(String value) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value);
  }

  static bool isPassword(String value) {
    return RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(value);
  }

  static bool isUrl(String value) {
    return RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
    ).hasMatch(value);
  }

  static bool isPhone(String value) {
    return RegExp(r'^\+?[\d\s-]{10,}$').hasMatch(value);
  }

  static bool isNumeric(String value) {
    return RegExp(r'^\d+$').hasMatch(value);
  }

  static bool isAlpha(String value) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(value);
  }

  static bool isAlphanumeric(String value) {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value);
  }
}
