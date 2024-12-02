import 'package:equatable/equatable.dart';
import 'package:rh_host/src/core/error/failures/failure.dart';

sealed class PasscodeState extends Equatable {
  const PasscodeState();

  @override
  List<Object?> get props => [];
}

class PasscodeInitial extends PasscodeState {
  const PasscodeInitial();
}

class PasscodeLoading extends PasscodeState {
  const PasscodeLoading();
}

class PasscodeEnabled extends PasscodeState {
  const PasscodeEnabled({required this.isEnabled});

  final bool isEnabled;

  @override
  List<Object?> get props => [isEnabled];
}

class PasscodeSet extends PasscodeState {
  const PasscodeSet({required this.isSet});

  final bool isSet;

  @override
  List<Object?> get props => [isSet];
}
class PasscodeShowRequired extends PasscodeState {
  const PasscodeShowRequired({required this.shouldShow});

  final bool shouldShow;

  @override
  List<Object?> get props => [shouldShow];
}

class PasscodeVerified extends PasscodeState {
  const PasscodeVerified();
}

class PasscodeInvalid extends PasscodeState {
  const PasscodeInvalid();
}

class PasscodeError extends PasscodeState {
  const PasscodeError(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
