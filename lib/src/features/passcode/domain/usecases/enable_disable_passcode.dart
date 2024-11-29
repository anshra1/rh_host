import 'package:rh_host/src/core/typedef/typedef.dart';
import 'package:rh_host/src/core/usecases/usecases.dart';
import 'package:rh_host/src/features/passcode/domain/repositories/passcode_repo.dart';

class EnableDisablePasscode extends FutureUseCaseWithoutParams<void> {
  EnableDisablePasscode({
    required this.passcodeRepo,
  });

  final PasscodeRepo passcodeRepo;

  @override
  ResultFuture<void> call() {
    return passcodeRepo.enableDisablePasscode();
  }
}
