// Dart imports:
import 'dart:async';

// Project imports:
import 'package:rh_host/src/core/enum/storage_type.dart';

abstract class AppStorage {
  Future<bool> init();
  Future<T?> read<T>(String key);
  Future<bool> write<T>(String key, T value);
  Future<bool> delete(String key);
  Future<bool> clear();
  Future<bool> has(String key);
//  Stream<T?> watch<T>(String key);
  Future<Set<String>> getKeys();
  Future<void> reload();
  Future<void> dispose();
  Future<bool> writeBatch(Map<String, dynamic> values);
  Future<StorageType?> getType(String key);
}

/// Mixin for validating storage operations
mixin StorageValidation {
  bool isValidType<T>() {
    return T == String ||
        T == int ||
        T == double ||
        T == bool ||
        T == List<String>;
  }

  StorageType getStorageType<T>() {
    if (T == String) return StorageType.string;
    if (T == int) return StorageType.integer;
    if (T == double) return StorageType.double;
    if (T == bool) return StorageType.boolean;
    if (T == List<String>) return StorageType.stringList;
    throw UnsupportedError('Type $T not supported');
  }
}
