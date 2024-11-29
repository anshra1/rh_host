import 'package:rh_host/src/core/typedef/typedef.dart';

abstract class PasscodeRepo {
  ResultFuture<void> setNewPasscode({
    required int newPasscode,
    required int confirmPasscode,
    required int masterPasscode,
  });

  ResultFuture<bool> verifyPasscode(int passcode);

  ResultFuture<void> enableDisablePasscode();

  ResultFuture<bool> shouldShowPasscode();
}
