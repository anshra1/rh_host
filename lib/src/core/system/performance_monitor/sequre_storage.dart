// import 'dart:convert';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:synchronized/synchronized.dart';

// class SecureStorageService {
//   SecureStorageService({
//     required FlutterSecureStorage secureStorage,
//   }) : _secureStorage = secureStorage;

//   final FlutterSecureStorage _secureStorage;
//   final _lock = Lock();
//   static const _keyPrefix = 'app_';

//   Future<void> saveSecurely<T>(String key, T value) async {
//     await _lock.synchronized(() async {
//       final jsonStr = jsonEncode(value);
//       final hashedKey = _hashKey(key);
//       await _secureStorage.write(
//         key: '$_keyPrefix$hashedKey',
//         value: jsonStr,
//       );
//     });
//   }

//   Future<T?> getSecurely<T>(String key) async {
//     return _lock.synchronized(() async {
//       final hashedKey = _hashKey(key);
//       final jsonStr = await _secureStorage.read(key: '$_keyPrefix$hashedKey');

//       if (jsonStr == null) return null;

//       try {
//         final dynamic value = jsonDecode(jsonStr);
//         return value as T;
//       } catch (e) {
//         return null;
//       }
//     });
//   }

//   Future<void> deleteSecurely(String key) async {
//     await _lock.synchronized(() async {
//       final hashedKey = _hashKey(key);
//       await _secureStorage.delete(key: '$_keyPrefix$hashedKey');
//     });
//   }

//   Future<void> clearAll() async {
//     await _lock.synchronized(() async {
//       await _secureStorage.deleteAll();
//     });
//   }

//   String _hashKey(String key) {
//     final bytes = utf8.encode(key);
//     final digest = sha256.convert(bytes);
//     return digest.toString();
//   }
// }
