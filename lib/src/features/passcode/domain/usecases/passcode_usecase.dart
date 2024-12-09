// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:rh_host/src/core/other_/typedef/typedef.dart';
import 'package:rh_host/src/core/other_/usecases/usecases.dart';
import 'package:rh_host/src/features/passcode/domain/repositories/passcode_repo.dart';

class SetNewPasscode extends FutureUseCaseWithParams<bool, SetNewPasscodeParams> {
  const SetNewPasscode({required this.passcodeRepo});

  final PasscodeRepo passcodeRepo;

  @override
  ResultFuture<bool> call(SetNewPasscodeParams params) {
    return passcodeRepo.setNewPasscode(
      newPasscode: params.newPasscode,
      confirmPasscode: params.confirmPasscode,
      masterPasscode: params.masterPasscode,
    );
  }
}

class VerifyPasscode extends FutureUseCaseWithParams<bool, VerifyPasscodeParams> {
  const VerifyPasscode({required this.passcodeRepo});

  final PasscodeRepo passcodeRepo;

  @override
  ResultFuture<bool> call(VerifyPasscodeParams params) {
    return passcodeRepo.verifyPasscode(params.passcode);
  }
}

class EnableDisablePasscode extends FutureUseCaseWithoutParams<bool> {
  const EnableDisablePasscode({required this.passcodeRepo});

  final PasscodeRepo passcodeRepo;

  @override
  ResultFuture<bool> call() {
    return passcodeRepo.enableDisablePasscode();
  }
}

class ShouldShowPasscode extends FutureUseCaseWithoutParams<bool> {
  const ShouldShowPasscode({required this.passcodeRepo});

  final PasscodeRepo passcodeRepo;

  @override
  ResultFuture<bool> call() {
    return passcodeRepo.shouldShowPasscode();
  }
}

// Params classes
class SetNewPasscodeParams extends Equatable {
  const SetNewPasscodeParams({
    required this.newPasscode,
    required this.confirmPasscode,
    required this.masterPasscode,
  });

  final int newPasscode;
  final int confirmPasscode;
  final int masterPasscode;

  @override
  List<Object?> get props => [newPasscode, confirmPasscode, masterPasscode];
}

class VerifyPasscodeParams extends Equatable {
  const VerifyPasscodeParams(this.passcode);

  final int passcode;

  @override
  List<Object?> get props => [passcode];
}
