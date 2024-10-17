import 'package:rh_host/src/core/typedef/typedef.dart';
import 'package:rh_host/src/core/usecases/usecases.dart';
import '../repositories/passcode_repo.dart';

class ShouldShowPasscode extends FutureUseCaseWithoutParams<bool> {
  ShouldShowPasscode({
    required this.authRepo,
  });

  final PasscodeRepo authRepo;

  @override
  ResultFuture<bool> call() {
    return authRepo.shouldShowPasscode();
  }
}
