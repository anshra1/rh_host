import 'package:rh_host/src/core/typedef/typedef.dart';
import 'package:rh_host/src/core/usecases/usecases.dart';
import '../repositories/passcode_repo.dart';

class ConfirmPasscode extends FutureUseCaseWithoutParams<void> {
  ConfirmPasscode({
    required this.authRepo,
  });

  final PasscodeRepo authRepo;

  @override
  ResultFuture<void> call() {
    return authRepo.confirmPasscode();
  }
}
