// ignore_for_file: public_member_api_docs, sort_constructors_first

// Dart imports:
import 'dart:async';

// Project imports:
import 'package:rh_host/src/core/enum/storage_type.dart';
import 'package:rh_host/src/core/system/logger/debug_logger.dart';
import 'package:rh_host/src/core/system/storage/app_storage.dart';
import 'package:rh_host/src/core/system/storage/storage_context.dart';
import 'package:rh_host/src/core/system/storage/storage_retry_manager.dart';
// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsStorages implements AppStorage {
  SharedPrefsStorages({required SharedPreferences prefs}) : _prefs = prefs;

  final SharedPreferences _prefs;
  bool _isInitialized = false;

  @override
  Future<bool> init() async {
    return StorageRetryManager.withRetry(
      operation: () async {
        if (_isInitialized) return true;

        try {
          await _prefs.reload();
          _isInitialized = true;
          return true;
        } catch (e) {
          _isInitialized = false;
          rethrow; // Preserve raw error for RetryManager
        }
      },
      methodName: 'initialization',
      fallbackMessage: 'Failed to initialize storage',
    );
  }

  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await init();
    }
  }

  @override
  Future<T?> read<T>(String key) async {
    await _ensureInitialized();
    return StorageRetryManager.withRetry(
      operation: () async {
        try {
          if (T == String) {
            return _prefs.getString(key) as T?;
          } else if (T == int) {
            return _prefs.getInt(key) as T?;
          } else if (T == bool) {
            return _prefs.getBool(key) as T?;
          } else if (T == double || T == num) {
            return _prefs.getDouble(key) as T?;
          } else if (T == List<String>) {
            return _prefs.getStringList(key) as T?;
          }
          throw UnsupportedError('Type $T not supported');
        } catch (e) {
          rethrow; // Preserve raw error
        }
      },
      methodName: 'read',
      fallbackMessage: 'Failed to read from storage',
      context: StorageErrorContext(
        key: key,
        operation: 'reading',
        additionalInfo: {'type': T.toString()},
      ),
    );
  }

  @override
  Future<bool> write<T>(String key, T value) async {
    await _ensureInitialized();

    return StorageRetryManager.withRetry(
      operation: () async {
        try {
          if (value == null) {
            throw ArgumentError.notNull('value');
          }

          bool result;

          // Handling supported types
          if (value is String) {
            result = await _prefs.setString(key, value);
          } else if (value is int) {
            result = await _prefs.setInt(key, value);
          } else if (value is bool) {
            result = await _prefs.setBool(key, value);
          } else if (value is double) {
            result = await _prefs.setDouble(key, value);
          } else if (value is num) {
            result = await _prefs.setDouble(key, value.toDouble());
          } else if (value is List<String>) {
            result = await _prefs.setStringList(key, value);
          } else if (value is List) {
            // Convert list of non-String elements to List<String>
            final stringList = value.map((e) => e.toString()).toList();
            result = await _prefs.setStringList(key, stringList);
          } else {
            // For unsupported types, throw an error
            throw StateError('Unsupported value type: ${value.runtimeType}');
          }

          // Check the result and throw an error if failed
          if (!result) {
            throw StateError('Write operation failed for key: $key');
          }

          return true;
        } catch (e, s) {
          // Log error with useful context
          DebugLogger.instance.error(
            'Error during write operation for key: $key',
            e,
            s,
          );
          rethrow; // Preserve raw error
        }
      },
      methodName: 'write',
      fallbackMessage: 'Failed to write to storage',
      context: StorageErrorContext(
        key: key,
        operation: 'writing',
        additionalInfo: {
          'type': value.runtimeType.toString(),
          'value_length': value.toString().length,
        },
      ),
    );
  }

  @override
  Future<bool> delete(String key) async {
    await _ensureInitialized();
    return StorageRetryManager.withRetry(
      operation: () async {
        try {
          final result = await _prefs.remove(key);
          if (!result) {
            throw StateError('Delete operation failed');
          }
          return true;
        } catch (e) {
          rethrow; // Preserve raw error
        }
      },
      methodName: 'delete',
      fallbackMessage: 'Failed to delete from storage',
      context: StorageErrorContext(
        key: key,
        operation: 'deleting',
      ),
    );
  }

  @override
  Future<bool> clear() async {
    await _ensureInitialized();
    return StorageRetryManager.withRetry(
      operation: () async {
        try {
          final result = await _prefs.clear();
          if (!result) {
            throw StateError('Clear operation failed');
          }
          return true;
        } catch (e) {
          rethrow; // Preserve raw error
        }
      },
      methodName: 'clear',
      fallbackMessage: 'Failed to clear storage',
      context: const StorageErrorContext(operation: 'clearing'),
    );
  }

  @override
  Future<bool> has(String key) async {
    await _ensureInitialized();
    return StorageRetryManager.withRetry(
      operation: () async {
        try {
          return _prefs.containsKey(key);
        } catch (e) {
          rethrow; // Preserve raw error
        }
      },
      methodName: 'has',
      fallbackMessage: 'Failed to check key existence',
      context: StorageErrorContext(
        key: key,
        operation: 'checking existence',
      ),
    );
  }

  @override
  Future<Set<String>> getKeys() async {
    await _ensureInitialized();
    return StorageRetryManager.withRetry(
      operation: () async {
        try {
          return _prefs.getKeys();
        } catch (e) {
          rethrow; // Preserve raw error
        }
      },
      methodName: 'getKeys',
      fallbackMessage: 'Failed to get storage keys',
      context: const StorageErrorContext(operation: 'getting keys'),
    );
  }

  @override
  Future<void> reload() async {
    await _ensureInitialized();
    return StorageRetryManager.withRetry(
      operation: () async {
        try {
          await _prefs.reload();
        } catch (e) {
          rethrow; // Preserve raw error
        }
      },
      methodName: 'reload',
      fallbackMessage: 'Failed to reload storage',
      context: const StorageErrorContext(operation: 'reloading'),
    );
  }

  @override
  Future<StorageType?> getType(String key) async {
    await _ensureInitialized();
    return StorageRetryManager.withRetry(
      operation: () async {
        try {
          if (!_prefs.containsKey(key)) return null;

          final value = _prefs.get(key);
          if (value == null) return null;

          return switch (value) {
            String() => StorageType.string,
            int() => StorageType.integer,
            double() => StorageType.double,
            bool() => StorageType.boolean,
            List<String>() => StorageType.stringList,
            _ => throw UnsupportedError('Unsupported type: ${value.runtimeType}')
          };
        } catch (e) {
          rethrow; // Preserve raw error
        }
      },
      methodName: 'getType',
      fallbackMessage: 'Failed to get type for key',
      context: StorageErrorContext(
        key: key,
        operation: 'getting type',
      ),
    );
  }

  @override
  Future<bool> writeBatch(Map<String, dynamic> values) async {
    await _ensureInitialized();
    return StorageRetryManager.withRetry(
      operation: () async {
        try {
          // First validate all values
          for (final entry in values.entries) {
            final value = entry.value;
            if (value == null) {
              throw ArgumentError.notNull('value for key: ${entry.key}');
            }

            if (!(value is String ||
                value is int ||
                value is double ||
                value is num ||
                value is bool ||
                value is List<String> ||
                value is List)) {
              throw UnsupportedError(
                'Unsupported type ${value.runtimeType} for key: ${entry.key}',
              );
            }
          }

          // Then perform writes
          for (final entry in values.entries) {
            final success = await write(entry.key, entry.value);
            if (!success) {
              throw StateError('Failed to write value for key: ${entry.key}');
            }
          }

          return true;
        } catch (e) {
          rethrow; // Preserve raw error
        }
      },
      methodName: 'writeBatch',
      fallbackMessage: 'Failed to perform batch write',
      context: StorageErrorContext(
        operation: 'batch writing',
        additionalInfo: {
          'batch_size': values.length,
          'keys': values.keys.toList(),
        },
      ),
    );
  }

  @override
  Future<void> dispose() async {
    await _ensureInitialized();
  }
}
