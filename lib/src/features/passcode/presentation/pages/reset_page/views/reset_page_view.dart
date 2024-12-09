part of '../../../../import.dart';

class ResetPageView extends HookWidget {
  const ResetPageView({
    required this.isLoading,
    required this.shouldClearFields,
    required this.onSubmit,
    super.key,
  });

  final bool isLoading;
  final bool shouldClearFields;
  final Future<void> Function(int newPasscode, int confirmPasscode, int masterPasscode)
      onSubmit;

  @override
  Widget build(BuildContext context) {
    final newPasscodeController = useTextEditingController();
    final confirmPasscodeController = useTextEditingController();
    final masterPasscodeController = useTextEditingController();
    final formKey = useMemoized(GlobalKey<FormState>.new);

    useEffect(
      () {
        if (shouldClearFields) {
          newPasscodeController.clear();
          confirmPasscodeController.clear();
          masterPasscodeController.clear();
        }
        return null;
      },
      [shouldClearFields],
    );

    Future<void> submit() async {
      if (!formKey.currentState!.validate()) return;

      final newPasscode = int.parse(newPasscodeController.text);
      final confirmPasscode = int.parse(confirmPasscodeController.text);
      final masterPasscode = int.parse(masterPasscodeController.text);

      await onSubmit(newPasscode, confirmPasscode, masterPasscode);
    }

    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Set New Passcode',
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TitledInputField(
              controller: newPasscodeController,
              title: 'New Passcode',
              keyboardType: TextInputType.number,
              maxLength: 4,
              inputFormatters: AppInputFormatters.passcode,
              validator: PasscodeValidator.validatePasscode,
            ),
            const Gap(16),
            TitledInputField(
              controller: confirmPasscodeController,
              title: 'Confirm Passcode',
              keyboardType: TextInputType.number,
              maxLength: 4,
              inputFormatters: AppInputFormatters.passcode,
              validator: (value) => PasscodeValidator.validateConfirmPasscode(
                value,
                newPasscodeController.text,
              ),
            ),
            const Gap(16),
            TitledInputField(
              controller: masterPasscodeController,
              title: 'Master Passcode',
              keyboardType: TextInputType.number,
              maxLength: 4,
              inputFormatters: AppInputFormatters.passcode,
              validator: PasscodeValidator.validateMasterPasscode,
            ),
            const Gap(32),
            AppElevatedButton(
              label: 'Update Passcode',
              onPressed: submit,
              isLoading: isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
