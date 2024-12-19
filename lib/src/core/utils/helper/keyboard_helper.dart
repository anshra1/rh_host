class KeyboardHelper {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  static double keyboardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }
}
