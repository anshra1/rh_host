import 'package:rh_host/src/core/page/dialog/alert_dialog_model.dart';

class ErrorDialog extends AlertDialogModel<bool> {
  ErrorDialog({required super.message})
      : super(
          title: 'Error',
          buttons: {
            'cancel': false,
            'ok': true,
          },
        );
}