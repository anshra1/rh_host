// class SharedPrefsStorage implements AppStorage {
//   SharedPrefsStorage._();
//   static SharedPrefsStorage? _instance;

//   static Future<SharedPrefsStorage> getInstance() async {
//     if (_instance == null) {
//       final instance = SharedPrefsStorage._();
//       await instance.init();
//       _instance = instance;
//     }
//     return _instance!;
//   }

//   late SharedPreferences _prefs;
//   final _controller = StreamController<String>.broadcast();

//   @override
//   Future<bool> init() async {
//     try {
//       _prefs = await SharedPreferences.getInstance();
//       return true;
//     } catch (e, s) {
//       throw ExceptionThrower.sharedPrefanceException(
//         e,
//         s,
//         'init',
//         'Failed to initialize local storage',
//       );

//     }
//   }

//   @override
//   Future<T?> read<T>(String key) async {
//     try {
//       if (T == String) {
//         return _prefs.getString(key) as T?;
//       } else if (T == int) {
//         return _prefs.getInt(key) as T?;
//       } else if (T == bool) {
//         return _prefs.getBool(key) as T?;
//       } else if (T == double) {
//         return _prefs.getDouble(key) as T?;
//       } else if (T == List<String>) {
//         return _prefs.getStringList(key) as T?;
//       }
//       throw UnsupportedError('Type $T not supported');
//     } catch (e, s) {
//       throw CacheException(
//         showUImessage: 'Failed to read from storage',
//         debugCode: 'storage_read_failed',
//         methodName: 'read',
//         stackTrace: s,
//         errorCode: ErrorCode.localStorageError,
//       );
//     }
//   }

//   @override
//   Future<bool> write<T>(String key, T value) async {
//     try {
//       bool result;
//       if (T == String) {
//         result = await _prefs.setString(key, value as String);
//       } else if (T == int) {
//         result = await _prefs.setInt(key, value as int);
//       } else if (T == bool) {
//         result = await _prefs.setBool(key, value as bool);
//       } else if (T == double) {
//         result = await _prefs.setDouble(key, value as double);
//       } else if (T == List<String>) {
//         result = await _prefs.setStringList(key, value as List<String>);
//       } else {
//         throw UnsupportedError('Type $T not supported');
//       }

//       if (result) {
//         _controller.add(key);
//         return true;
//       }
//       return false;
//     } catch (e, s) {
//       throw CacheException(
//         showUImessage: 'Failed to write to storage',
//         debugCode: 'storage_write_failed',
//         methodName: 'write',
//         stackTrace: s,
//         errorCode: ErrorCode.localStorageError,
//       );
//     }
//   }

//   @override
//   Future<bool> delete(String key) async {
//     try {
//       final result = await _prefs.remove(key);
//       if (result) {
//         _controller.add(key);
//       }
//       return result;
//     } catch (e, s) {
//       throw CacheException(
//         showUImessage: 'Failed to delete from storage',
//         debugCode: 'storage_delete_failed',
//         methodName: 'delete',
//         stackTrace: s,
//         errorCode: ErrorCode.localStorageError,
//       );
//     }
//   }

//   @override
//   Future<bool> clear() async {
//     try {
//       final result = await _prefs.clear();
//       if (result) {
//         // Notify all listeners that storage was cleared
//         final keys = _prefs.getKeys();
//         for (final key in keys) {
//           _controller.add(key);
//         }
//       }
//       return result;
//     } catch (e, s) {
//       throw CacheException(
//         showUImessage: 'Failed to clear storage',
//         debugCode: 'storage_clear_failed',
//         methodName: 'clear',
//         stackTrace: s,
//         errorCode: ErrorCode.localStorageError,
//       );
//     }
//   }

//   @override
//   Future<bool> has(String key) async {
//     try {
//       return _prefs.containsKey(key);
//     } catch (e, s) {
//       throw CacheException(
//         showUImessage: 'Failed to check key existence',
//         debugCode: 'storage_check_failed',
//         methodName: 'has',
//         stackTrace: s,
//         errorCode: ErrorCode.localStorageError,
//       );
//     }
//   }

//   @override
//   Stream<T?> watch<T>(String key) {
//     return _controller.stream
//         .where((updatedKey) => updatedKey == key)
//         .asyncMap((_) => read<T>(key));
//   }

//   @override
//   Future<void> dispose() async {
//     await _controller.close();
//   }

//   // Additional helper methods
//   @override
//   Future<Set<String>> getKeys() async {
//     try {
//       return _prefs.getKeys();
//     } catch (e, s) {
//       throw CacheException(
//         showUImessage: 'Failed to get storage keys',
//         debugCode: 'storage_keys_failed',
//         methodName: 'getKeys',
//         stackTrace: s,
//         errorCode: ErrorCode.localStorageError,
//       );
//     }
//   }

//   @override
//   Future<void> reload() async {
//     try {
//       await _prefs.reload();
//     } catch (e, s) {
//       throw CacheException(
//         showUImessage: 'Failed to reload storage',
//         debugCode: 'storage_reload_failed',
//         methodName: 'reload',
//         stackTrace: s,
//         errorCode: ErrorCode.localStorageError,
//       );
//     }
//   }

//   @override
//   Future<StorageType?> getType(String key) async {
//     try {
//       // Check if key exists
//       if (!await has(key)) {
//         return null;
//       }

//       // Get the value and determine its type
//       final value = _prefs.get(key);
//       if (value == null) {
//         return null;
//       }

//       // Return corresponding StorageType
//       if (value is String) {
//         return StorageType.string;
//       } else if (value is int) {
//         return StorageType.integer;
//       } else if (value is double) {
//         return StorageType.double;
//       } else if (value is bool) {
//         return StorageType.boolean;
//       } else if (value is List<String>) {
//         return StorageType.stringList;
//       }
//       throw const CacheException(
//         showUImessage: 'Failed to reload storage',
//         debugCode: 'storage_reload_failed',
//         methodName: 'reload',
//         errorCode: ErrorCode.localStorageError,
//       );
//       // throw StorageException(
//       //   message: 'Unknown storage type for key: $key',
//       //   debugCode: 'unknown_type',
//       //   methodName: 'getType',
//       // );
//     } catch (e, s) {
//       throw CacheException(
//         showUImessage: 'Failed to reload storage',
//         debugCode: 'storage_reload_failed',
//         methodName: 'reload',
//         stackTrace: s,
//         errorCode: ErrorCode.localStorageError,
//       );
//       // throw StorageException(
//       //   message: 'Failed to get type for key: $key',
//       //   debugCode: 'type_check_failed',
//       //   methodName: 'getType',
//       //   stackTrace: s,
//       //   originalError: e,
//       // );
//     }
//   }

//   @override
//   Future<bool> writeBatch(Map<String, dynamic> values) async {
//     try {
//       // Validate all values first
//       for (final entry in values.entries) {
//         final value = entry.value;
//         if (!(value is String ||
//             value is int ||
//             value is double ||
//             value is bool ||
//             value is List<String>)) {
//           throw UnsupportedError(
//             'Unsupported type ${value.runtimeType} for key: ${entry.key}',
//           );
//         }
//       }

//       // Perform batch write
//       for (final entry in values.entries) {
//         final key = entry.key;
//         final value = entry.value;

//         bool success;
//         if (value is String) {
//           success = await _prefs.setString(key, value);
//         } else if (value is int) {
//           success = await _prefs.setInt(key, value);
//         } else if (value is double) {
//           success = await _prefs.setDouble(key, value);
//         } else if (value is bool) {
//           success = await _prefs.setBool(key, value);
//         } else if (value is List<String>) {
//           success = await _prefs.setStringList(key, value);
//         } else {
//           success = false;
//         }

//         if (!success) {
//           throw const CacheException(
//             showUImessage: 'Failed to reload storage',
//             debugCode: 'storage_reload_failed',
//             methodName: 'reload',
//             errorCode: ErrorCode.localStorageError,
//           );
//           // throw StorageException(
//           //   message: 'Failed to write value for key: $key',
//           //   debugCode: 'batch_write_item_failed',
//           //   methodName: 'writeBatch',
//           // );
//         }

//         // Notify listeners
//         _controller.add(key);
//       }

//       return true;
//     } catch (e, s) {
//       throw CacheException(
//         showUImessage: 'Failed to reload storage',
//         debugCode: 'storage_reload_failed',
//         methodName: 'reload',
//         stackTrace: s,
//         errorCode: ErrorCode.localStorageError,
//       );
//       // throw StorageException(
//       //   message: 'Failed to perform batch write',
//       //   debugCode: 'batch_write_failed',
//       //   methodName: 'writeBatch',
//       //   stackTrace: s,
//       //   originalError: e,
//       // );
//     }
//   }
// }

// // Usage example:
// void main() async {
//   final storage = await SharedPrefsStorage.getInstance();

//   // Write
//   await storage.write('user_name', 'John');

//   // Read
//   final name = await storage.read<String>('user_name');

//   // Watch for changes
//   storage.watch<String>('user_name').listen((newValue) {
//     print('Name changed to: $newValue');
//   });

//   // Check if exists
//   final hasKey = await storage.has('user_name');

//   // Delete
//   await storage.delete('user_name');

//   // Clear all
//   await storage.clear();

//   // Clean up
//   await storage.dispose();
// }
