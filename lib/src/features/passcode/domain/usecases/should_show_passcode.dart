import 'package:rh_host/src/core/typedef/typedef.dart';
import 'package:rh_host/src/core/usecases/usecases.dart';
import 'package:rh_host/src/features/passcode/domain/repositories/passcode_repo.dart';

class ShouldShowPasscodeUseCase extends FutureUseCaseWithoutParams<bool> {
  ShouldShowPasscodeUseCase({
    required this.passcodeRepo,
  });

  final PasscodeRepo passcodeRepo;

  @override
  ResultFuture<bool> call() {
    return passcodeRepo.shouldShowPasscode();
  }
}
