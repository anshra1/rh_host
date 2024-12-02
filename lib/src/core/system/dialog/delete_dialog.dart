import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';
import 'package:rh_host/src/core/system/dialog/alert_dialog_model.dart';

@immutable
class DeleteDialog extends AlertDialogModel<bool> {
  const DeleteDialog()
      : super(
          title: 'Delete List',
          message: 'Are you sure you want to delete this list?',
          buttons: const {
            'cancel': false,
            'Ok': true,
          },
        );
}
