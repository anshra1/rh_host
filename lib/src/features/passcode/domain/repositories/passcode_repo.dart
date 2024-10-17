import 'package:rh_host/src/core/typedef/typedef.dart';

abstract class PasscodeRepo {
  
  ResultFuture<void> setNewPasscode();

  ResultFuture<void> confirmPasscode();

  ResultFuture<void> verifyPasscode();

  ResultFuture<void> enableDisablePasscode();
  
   ResultFuture<bool> shouldShowPasscode();

}
