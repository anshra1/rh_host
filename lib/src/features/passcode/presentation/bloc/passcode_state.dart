// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_positional_boolean_parameters
import 'package:equatable/equatable.dart';

abstract class PasscodeState extends Equatable {
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

class PasscodeSet extends PasscodeState {
  const PasscodeSet();
}

class PasscodeVerified extends PasscodeState {
  const PasscodeVerified();
}

class PasscodeSettingChanged extends PasscodeState {
  const PasscodeSettingChanged();
}

class ShouldShowPasscode extends PasscodeState {
  const ShouldShowPasscode(this.shouldShow);

  final bool shouldShow;

  @override
  List<Object?> get props => [shouldShow];
}

class PasscodeError extends PasscodeState {
  const PasscodeError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
