import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rh_host/src/features/passcode/domain/usecases/enable_disable_passcode.dart';
import 'package:rh_host/src/features/passcode/domain/usecases/set_new_passcode.dart';
import 'package:rh_host/src/features/passcode/domain/usecases/should_show_passcode.dart';
import 'package:rh_host/src/features/passcode/domain/usecases/verify_passcode.dart';
import 'package:rh_host/src/features/passcode/presentation/bloc/passcode_state.dart';

class PasscodeCubit extends Cubit<PasscodeState> {
  PasscodeCubit({
    required SetNewPasscode setNewPasscode,
    required VerifyPasscode verifyPasscode,
    required EnableDisablePasscode enableDisablePasscode,
    required ShouldShowPasscodeUseCase shouldShowPasscodeUseCase,
  })  : _setNewPasscode = setNewPasscode,
        _verifyPasscode = verifyPasscode,
        _enableDisablePasscode = enableDisablePasscode,
        _shouldShowPasscodeUseCase = shouldShowPasscodeUseCase,
        super(const PasscodeInitial());

  final SetNewPasscode _setNewPasscode;
  final VerifyPasscode _verifyPasscode;
  final EnableDisablePasscode _enableDisablePasscode;
  final ShouldShowPasscodeUseCase _shouldShowPasscodeUseCase;

  Future<void> setNewPasscode(SetNewPasscodeParams params) async {
    emit(const PasscodeLoading());

    final result = await _setNewPasscode(params);

    result.fold(
      (failure) => emit(PasscodeError(failure.errorMessage)),
      (_) => emit(const PasscodeSet()),
    );
  }

  Future<void> verifyPasscode(int passcode) async {
    print('z start');
    emit(const PasscodeLoading());
    final result = await _verifyPasscode(passcode);
    result.fold(
      (failure) => emit(PasscodeError(failure.message)),
      (isVerified) => emit(
        isVerified ? const PasscodeVerified() : const PasscodeError('Invalid passcode'),
      ),
    );
    print('z end');
  }

  Future<void> togglePasscodeScreen() async {
    emit(const PasscodeLoading());
    final result = await _enableDisablePasscode();
    result.fold(
      (failure) => emit(PasscodeError(failure.errorMessage)),
      (_) => emit(const PasscodeSettingChanged()),
    );
  }

  Future<void> checkShouldShowPasscode() async {
    emit(const PasscodeLoading());
    final result = await _shouldShowPasscodeUseCase();
    result.fold(
      (failure) => emit(PasscodeError(failure.errorMessage)),
      (shouldShow) => emit(ShouldShowPasscode(shouldShow)),
    );
  }
}
