class Strings {
  // firebase
  // passcode
  static const String passcodeStoreCollection = 'setting';
  static const String passcodeStoreDocId = 'passcode';
  static const String setMasterPasscode = 'master-passcode';
  static const String appPasscode = 'user-passcode';
  static const String passcodeLastLoginupdatedAt = 'updated_at';
  static const String internetRequiredToSetPasscode =
      'Internet connection required to set passcode';
  static const String connectionLostDuringOperation = 'Connection lost during operation';

  // passcode
  static const String failedToSetNewPasscode = 'Failed to set new passcode';
  static const String invalidMasterPasscode = 'invalid master passcode';

  static const String newAndConfirmPasscodeNoMatch = 'New and confirm not match';
  static const String passcodeNotSet = 'passcode is not set';
  static const String failedToVerifyPasscode = 'Failed to verify passcode';
  static const String pleaseEnterPasscode = 'Please enter your Passcode';
  static const String forgetPin = 'Forgot PIN?';
  static const String invalidPinCode = 'Invalid Pin Code';

  // Error
  static const String unknownError = 'unknown Error';

  // internet connection
  static const String noInternetConnection = 'No internet connection';
}
