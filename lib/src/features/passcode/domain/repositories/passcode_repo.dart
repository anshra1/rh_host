import 'package:rh_host/src/core/other/typedef/typedef.dart';

abstract class PasscodeRepo {
  ResultFuture<bool> setNewPasscode({
    required int newPasscode,
    required int confirmPasscode,
    required int masterPasscode,
  });

  ResultFuture<bool> verifyPasscode(int passcode);

  ResultFuture<bool> enableDisablePasscode();

  ResultFuture<bool> shouldShowPasscode();
}
