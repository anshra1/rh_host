// lib/src/core/storage/storage_keys.dart

class StorageKeys {
  static const String prefix = 'app_';

  // passcode
  static const String passcodeKey = '${prefix}user_passcode';
  static const String passcodeEnabledKey = '${prefix}user_passcode';
  static const String lastLoginTimestampKey = '${prefix}last_login';
}
