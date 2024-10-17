
  part of 'passcode_bloc.dart';
  
  abstract class PasscodeState extends Equatable {
    const PasscodeState();
    
    @override
    List<Object> get props => [];
  }
  class PasscodeInitial extends PasscodeState {}
  