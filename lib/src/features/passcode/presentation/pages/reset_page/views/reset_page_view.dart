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
  final Future<void> Function(
    int newPasscode,
    int confirmPasscode,
    int masterPasscode,
  ) onSubmit;

  @override
  Widget build(BuildContext context) {
    // Controllers
    final newPasscodeController = useTextEditingController();
    final confirmPasscodeController = useTextEditingController();
    final masterPasscodeController = useTextEditingController();

    // Focus nodes
    final newPasscodeFocus = useFocusNode();
    final confirmPasscodeFocus = useFocusNode();
    final masterPasscodeFocus = useFocusNode();

    final formKey = useMemoized(GlobalKey<FormState>.new);

    // Clear fields effect
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

    return BaseScaffold.scrollable(
      padding: const EdgeInsets.all(32),
      appBar: const PrimaryAppBarWidget(
        title: 'Set New Passcode',
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 1,
      ),
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LabelTextField(
              controller: newPasscodeController,
              focusNode: newPasscodeFocus,
              title: 'New Passcode',
              keyboardType: TextInputType.number,
              inputFormatters: AppInputFormatters.passcode,
              validator: PasscodeValidator.validatePasscode,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(confirmPasscodeFocus),
              textInputAction: TextInputAction.next,
            ),
            Spacing.gapLG,
            LabelTextField(
              controller: confirmPasscodeController,
              focusNode: confirmPasscodeFocus,
              title: 'Confirm Passcode',
              keyboardType: TextInputType.number,
              inputFormatters: AppInputFormatters.passcode,
              validator: (value) => PasscodeValidator.validateConfirmPasscode(
                value,
                newPasscodeController.text,
              ),
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(masterPasscodeFocus),
              textInputAction: TextInputAction.next,
            ),
            Spacing.gapLG,
            LabelTextField(
              controller: masterPasscodeController,
              focusNode: masterPasscodeFocus,
              title: 'Master Passcode',
              keyboardType: TextInputType.number,
              inputFormatters: AppInputFormatters.passcode,
              validator: PasscodeValidator.validateMasterPasscode,
              onFieldSubmitted: (_) => submit(),
              textInputAction: TextInputAction.done,
            ),
            Spacing.gapXXL,
            PrimaryButton(
              label: 'Update Passcode',
              onPressed: submit,
            ),
          ],
        ),
      ),
    );
  }
}
