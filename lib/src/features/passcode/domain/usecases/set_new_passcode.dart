import 'package:equatable/equatable.dart';
import 'package:rh_host/src/core/typedef/typedef.dart';
import 'package:rh_host/src/core/usecases/usecases.dart';
import 'package:rh_host/src/features/passcode/domain/repositories/passcode_repo.dart';

// ignore: lines_longer_than_80_chars
class SetNewPasscode extends FutureUseCaseWithParams<void, SetNewPasscodeParams> {
  SetNewPasscode({
    required this.passcodeRepo,
  });

  final PasscodeRepo passcodeRepo;

  @override
  ResultFuture<void> call(SetNewPasscodeParams params) {
    return passcodeRepo.setNewPasscode(
      newPasscode: params.newPasscode,
      confirmPasscode: params.confirmPasscode,
      masterPasscode: params.masterPasscode,
    );
  }
}

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
