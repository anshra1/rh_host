// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/foundation.dart';

extension ObjectExt on Object {
  void printFirst({String messsage = ''}) {
    debugPrint('$this  $messsage ${Random().nextInt(100)} rebuild');
  }
}
