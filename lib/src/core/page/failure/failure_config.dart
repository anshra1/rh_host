import 'package:flutter/material.dart';
import 'package:rh_host/src/core/enum/error_codes.dart';
import 'package:rh_host/src/core/page/failure/failure_action.dart';
import 'package:rh_host/src/core/page/failure/failure_manager.dart';

class FailureConfig {
  const FailureConfig({
    this.defaultDuration = const Duration(seconds: 3),
    this.defaultSnackBarBehavior = SnackBarBehavior.floating,
    this.defaultDialogBarrierDismissible = true,
    this.shouldVibrate = true,
    this.maxVisibleSnackBars = 1,
    Map<ErrorCode, FailureAction>? actionMap,
  }) : actionMap = actionMap ?? const {};

  final Duration defaultDuration;
  final SnackBarBehavior defaultSnackBarBehavior;
  final bool defaultDialogBarrierDismissible;
  final bool shouldVibrate;
  final int maxVisibleSnackBars;
  final Map<ErrorCode, FailureAction> actionMap;
}

void main() {
  FailureManager().initialize(
    config: FailureConfig(
      actionMap: {
        ErrorCode.noInternet: FailureAction(
          label: 'Retry',
          onPressed: () {
            // Handle retry
          },
        ),
        ErrorCode.unauthorized: FailureAction(
          label: 'Login',
          onPressed: () {
            // Navigate to login
          },
        ),
      },
    ),
  );

// runApp(const MyApp());
}

// Usage in your bloc
// class PasscodeBloc extends Bloc<PasscodeEvent, PasscodeState> {
//   PasscodeBloc(this._repository) : super(PasscodeInitial()) {
//     on<SetNewPasscode>(_onSetNewPasscode);
//   }

//   Future<void> _onSetNewPasscode(
//     SetNewPasscode event,
//     Emitter<PasscodeState> emit,
//   ) async {
//     emit(PasscodeLoading());

//     final result = await _repository.setNewPasscode(
//       newPasscode: event.newPasscode,
//       confirmPasscode: event.confirmPasscode,
//       masterPasscode: event.masterPasscode,
//     );

//     result.fold(
//       (failure) {
//         emit(PasscodeError(failure));
//       },
//       (_) => emit(PasscodeSuccess()),
//     );
//   }
// }

// // Usage in your UI
// class PasscodePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<PasscodeBloc, PasscodeState>(
//       listener: (context, state) {
//         if (state is PasscodeError) {
//           FailureManager().show(context, state.failure);
//         }
//       },
//       child: // Your UI
//     );
//   }
// }
