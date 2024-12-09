// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:rh_host/src/features/passcode/domain/usecases/passcode_usecase.dart';
import 'package:rh_host/src/features/passcode/presentation/bloc/passcode_state.dart';

class PasscodeCubit extends Cubit<PasscodeState> {
  PasscodeCubit({
    required SetNewPasscode setNewPasscode,
    required VerifyPasscode verifyPasscode,
    required EnableDisablePasscode enableDisablePasscode,
    required ShouldShowPasscode shouldShowPasscode,
  })  : _setNewPasscode = setNewPasscode,
        _verifyPasscode = verifyPasscode,
        _enableDisablePasscode = enableDisablePasscode,
        _shouldShowPasscode = shouldShowPasscode,
        super(const PasscodeInitialState());

  final SetNewPasscode _setNewPasscode;
  final VerifyPasscode _verifyPasscode;
  final EnableDisablePasscode _enableDisablePasscode;
  final ShouldShowPasscode _shouldShowPasscode;

  Future<void> setNewPasscode({
    required int newPasscode,
    required int confirmPasscode,
    required int masterPasscode,
  }) async {
    emit(const PasscodeLoading());

    final result = await _setNewPasscode(
      SetNewPasscodeParams(
        newPasscode: newPasscode,
        confirmPasscode: confirmPasscode,
        masterPasscode: masterPasscode,
      ),
    );

    result.fold(
      (failure) => emit(PasscodeErrorState(failure)),
      (isSet) => emit(NewPasscodeSetState(isSet: isSet)),
    );
  }

  Future<void> verifyPasscode(int passcode) async {
    emit(const PasscodeLoading());

    final result = await _verifyPasscode(VerifyPasscodeParams(passcode));

    result.fold(
      (failure) => emit(PasscodeErrorState(failure)),
      (isValid) => emit(PasscodeVerifiedState(isValid: isValid)),
    );
  }

  Future<void> enableDisablePasscode() async {
    emit(const PasscodeLoading());

    final result = await _enableDisablePasscode();

    result.fold(
      (failure) => emit(PasscodeErrorState(failure)),
      (isEnabled) => emit(PasscodeEnabledState(isEnabled: isEnabled)),
    );
  }

  Future<void> shouldShowPasscode() async {
    emit(const PasscodeLoading());

    final result = await _shouldShowPasscode();

    result.fold(
      (failure) => emit(PasscodeErrorState(failure)),
      (shouldShow) => emit(PasscodeShowRequiredState(shouldShow: shouldShow)),
    );
  }
}
