class Patterns {
  const Patterns._();

  /// Only numbers allowed
  static final numericOnly = RegExp(r'^[0-9]+$');

  /// Email validation pattern
  static final email = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  /// Phone number pattern (simple)
  static final phone = RegExp(r'^\d{10}$');

  /// Password pattern (at least 8 chars, 1 uppercase, 1 number, 1 special char)
  static final strongPassword = RegExp(
    r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$&*~]).{8,}$',
  );

  /// Only alphabets (with spaces)
  static final alphabetsOnly = RegExp(r'^[a-zA-Z\s]+$');

  /// URL pattern
  static final url = RegExp(
    r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$',
  );

  /// Username pattern (alphanumeric and underscore only)
  static final username = RegExp(r'^[a-zA-Z0-9_]+$');
}
