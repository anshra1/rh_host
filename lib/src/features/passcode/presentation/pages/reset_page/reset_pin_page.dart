part of '../../../import.dart';

class ResetPinPage extends StatelessWidget {
  const ResetPinPage({super.key});

  static const String routeName = '/reset-pin-page';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PasscodeCubit, PasscodeState>(
      listenWhen: (previous, current) =>
          current is PasscodeLoading ||
          current is PasscodeErrorState ||
          current is NewPasscodeSetState,
      listener: (context, state) {
        switch (state) {
          case PasscodeLoading():
            LoadingController.instance.show(
              context,
              message: 'Setting new passcode...',
              timeout: const Duration(seconds: 10),
            );

          case PasscodeErrorState():
            LoadingController.instance.hide(context);
            FailureManager.instance.show(context, state.failure);

          case NewPasscodeSetState(isSet: false):
            LoadingController.instance.hide(context);

          case NewPasscodeSetState(isSet: true):
            LoadingController.instance.hide(context);
            context.go(PasscodePage.routeName);

          default:
            LoadingController.instance.hide(context);
        }
      },
      buildWhen: (previous, current) => current is! PasscodeLoading,
      builder: (context, state) {
        DebugLogger.instance.info('ResetPinPage build $state');

        return ResetPageView(
          isLoading: state is PasscodeLoading,
          shouldClearFields: state is PasscodeErrorState,
          onSubmit: (newPasscode, confirmPasscode, masterPasscode) async {
            await context.read<PasscodeCubit>().setNewPasscode(
                  newPasscode: newPasscode,
                  confirmPasscode: confirmPasscode,
                  masterPasscode: masterPasscode,
                );
          },
        );
      },
    );
  }
}
