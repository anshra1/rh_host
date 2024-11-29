part of '../../../passcode/import.dart';

class PasscodePage extends StatefulWidget {
  const PasscodePage({super.key});

  @override
  PasscodePageState createState() => PasscodePageState();
}

class PasscodePageState extends State<PasscodePage> {
  String _passcode = '';

  void _addDigit(String digit) {
    if (_passcode.length < 4) {
      setState(() {
        _passcode += digit;
      });

      // Check if passcode is complete (4 digits)
      if (_passcode.length == 4) {
        context.read<PasscodeCubit>().verifyPasscode(int.parse(_passcode));
      }
    }
  }

  void _removeDigit() {
    if (_passcode.isNotEmpty) {
      setState(() {
        _passcode = _passcode.substring(0, _passcode.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<PasscodeCubit, PasscodeState>(
          listener: (context, state) {
            if (state is PasscodeError) {
              CoreUtils.showSnackBar(context, state.message);
            } else if (state is PasscodeLoading) {
              // CoreUtils.showLoadingDialog(context);
            } else if (state is PasscodeVerified) {
              context.go(HomePage.routeName);
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    kGap50,
                    Icon(Icons.lock_outline, size: 50, color: AppColor.primaryColor),
                    kGap20,
                    Text(
                      Strings.pleaseEnterPinCode,
                      style: p18.bold,
                    ),
                    kGap20,
                    PasscodeInput(passcode: _passcode),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    forgetPin(context),
                    kGap5,
                    numberPad(),
                    kGap20,
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget numberPad() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        if (index == 9) {
          return const SizedBox.shrink();
        }
        if (index == 10) {
          return _buildKeypadButton('0');
        }
        if (index == 11) {
          return _buildKeypadButton(
            '⌫',
            onTap: _removeDigit,
            color: AppColor.red100,
          );
        }
        return _buildKeypadButton('${index + 1}');
      },
    ).pad(20);
  }

  Widget forgetPin(BuildContext context) {
    return TextButton(
      onPressed: () => context.go(RouteName.resetPinPage),
      child: Text(
        Strings.forgetPin,
        style: context.theme.textTheme.bodyLarge!.bold.primaryColor,
      ),
    ).padRight(10);
  }

  Widget _buildKeypadButton(String label, {VoidCallback? onTap, Color? color}) {
    return InkWell(
      onTap: onTap ?? () => _addDigit(label),
      child: Ink(
        decoration: BoxDecoration(
          color: color ?? AppColor.backgroundGrey200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: context.theme.textTheme.headlineSmall!.bold,
        ).center(),
      ),
    );
  }
}
