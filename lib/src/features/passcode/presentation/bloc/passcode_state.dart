// Package imports:
import 'package:equatable/equatable.dart';
import 'package:rh_host/src/core/error/failures/failure.dart';

sealed class PasscodeState extends Equatable {
  const PasscodeState();

  @override
  List<Object?> get props => [];
}

class PasscodeInitialState extends PasscodeState {
  const PasscodeInitialState();
}

class PasscodeLoading extends PasscodeState {
  const PasscodeLoading();
}

class PasscodeEnabledState extends PasscodeState {
  const PasscodeEnabledState({required this.isEnabled});

  final bool isEnabled;

  @override
  List<Object?> get props => [isEnabled];
}

class NewPasscodeSetState extends PasscodeState {
  const NewPasscodeSetState({required this.isSet});

  final bool isSet;

  @override
  List<Object?> get props => [isSet];
}

class PasscodeShowRequiredState extends PasscodeState {
  const PasscodeShowRequiredState({required this.shouldShow});

  final bool shouldShow;

  @override
  List<Object?> get props => [shouldShow];
}

class PasscodeVerifiedState extends PasscodeState {
  const PasscodeVerifiedState({required this.isValid});

  final bool isValid;

  @override
  List<Object?> get props => [isValid];
}


class PasscodeErrorState extends PasscodeState {
  const PasscodeErrorState(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
