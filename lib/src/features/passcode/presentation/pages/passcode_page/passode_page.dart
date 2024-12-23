part of '../../../import.dart';

class PasscodePage extends StatefulWidget {
  const PasscodePage({super.key});

  static const String routeName = '/passcode';

  @override
  PasscodePageState createState() => PasscodePageState();
}

class PasscodePageState extends State<PasscodePage> {
  String _passcode = '';

  @override
  void initState() {
    super.initState();
    context.read<PasscodeCubit>().shouldShowPasscode();
    DebugLogger.instance.info('PasscodePage initState');
  }

  void _handlePasscodeInput(String value) {
    if (_passcode.length < 4) {
      setState(() => _passcode += value);

      if (_passcode.length == 4) {
        context.read<PasscodeCubit>().verifyPasscode(int.parse(_passcode));
      }
    }
  }

  void _handlePasscodeDelete() {
    if (_passcode.isNotEmpty) {
      setState(() => _passcode = _passcode.substring(0, _passcode.length - 1));
    }
  }

  void _clearPasscode() => setState(() => _passcode = '');

  void _handleForgetPin() => context.pushNamed(ResetPinPage.routeName);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PasscodeCubit, PasscodeState>(
      listenWhen: (previous, current) =>
          current is PasscodeLoading ||
          current is PasscodeErrorState ||
          current is PasscodeVerifiedState ||
          current is PasscodeShowRequiredState,
      listener: (context, state) {
        switch (state) {
          case PasscodeLoading():
            LoadingController.instance.show(
              context,
              message: 'Verifying passcode...',
              timeout: const Duration(seconds: 10),
            );

          case PasscodeErrorState():
            LoadingController.instance.hide(context);
            _clearPasscode();
            FailureManager.instance.show(context, state.failure);

          case PasscodeVerifiedState(isValid: true):
            LoadingController.instance.hide(context);
            context.pushReplacementNamed(HomePage.routeName);

          case PasscodeVerifiedState(isValid: false):
            _clearPasscode();

            LoadingController.instance.hide(context);

            AlertManager.instance.show(
              context,
              const Alert(message: 'Invalid passcode', type: AlertType.warning),
            );

          case PasscodeShowRequiredState(shouldShow: false):
            LoadingController.instance.hide(context);
            context.go(HomePage.routeName);

          case PasscodeShowRequiredState(shouldShow: true):
            LoadingController.instance.hide(context);
            context.go(PasscodePage.routeName);

          default:
            LoadingController.instance.hide(context);
        }
      },
      buildWhen: (previous, current) => current is! PasscodeLoading,
      builder: (context, state) {
        
        return PasscodeView(
          passcode: _passcode,
          isError: state is PasscodeVerifiedState,
          isLoading: state is PasscodeLoading,
          onDigitTap: _handlePasscodeInput,
          onDelete: _handlePasscodeDelete,
          onForgetPin: _handleForgetPin,
        );
      },
    );
  }
}
