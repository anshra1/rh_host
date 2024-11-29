import 'package:rh_host/src/core/enum/%20error_catogory.dart';

extension FirebasePlugin on String {
  ErrorCategory get getErrorCategory {
    switch (this) {
      case 'firebase_auth':
        return ErrorCategory.authentication;
      case 'cloud_firestore':
        return ErrorCategory.firestoreClient;
      case 'firebase_storage':
        return ErrorCategory.firebaseStorage;
      case 'firebase_core':
        return ErrorCategory.firebaseCore;
      default:
        return ErrorCategory.unknown;
    }
  }
}
