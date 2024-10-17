
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:equatable/equatable.dart';
  
  part 'passcode_event.dart';
  part 'passcode_state.dart';
  
  class PasscodeBloc extends Bloc<PasscodeEvent, PasscodeState> {
    PasscodeBloc() : super(PasscodeInitial()) {
      on<PasscodeEvent>((event, emit) {
        // TODO: implement event handler
      });
    }
  }
