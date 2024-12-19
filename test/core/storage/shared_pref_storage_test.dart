// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:rh_host/src/core/enum/storage_type.dart';
import 'package:rh_host/src/core/error/exception/exception.dart';
import 'package:rh_host/src/core/system/storage/shared_pref_storage.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPrefs;
  late SharedPrefsStorages storage;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    when(() => mockPrefs.reload()).thenAnswer((_) async {});
    storage = SharedPrefsStorages(prefs: mockPrefs);
  });

  group('initialization', () {
    test('should initialize successfully', () async {
      when(() => mockPrefs.reload()).thenAnswer((_) async {});

      final result = await storage.init();

      expect(result, true);
      verify(() => mockPrefs.reload()).called(1);
    });

    test('should throw exception when initialization fails', () async {
      when(() => mockPrefs.reload())
          .thenThrow(PlatformException(code: 'E_INIT'));

      expect(() => storage.init(), throwsA(isA<Exception>()));
    });
  });

  group('read operations', () {
    // setUp(() async {
    //   await storage.init();
    // });

    test('should read String value', () async {
      const key = 'test_string';
      const value = 'test_value';
      when(() => mockPrefs.getString(key)).thenReturn(value);

      final result = await storage.read<String>(key);

      expect(result, value);
      verify(() => mockPrefs.getString(key)).called(1);
    });

    test('should read int value', () async {
      const key = 'test_int';
      const value = 42;
      when(() => mockPrefs.getInt(key)).thenReturn(value);

      final result = await storage.read<int>(key);

      expect(result, value);
      verify(() => mockPrefs.getInt(key)).called(1);
    });

    test('should read bool value', () async {
      const key = 'test_bool';
      const value = true;
      when(() => mockPrefs.getBool(key)).thenReturn(value);

      final result = await storage.read<bool>(key);

      expect(result, value);
      verify(() => mockPrefs.getBool(key)).called(1);
    });

    test('should read double value', () async {
      const key = 'test_double';
      const value = 3.14;
      when(() => mockPrefs.getDouble(key)).thenReturn(value);

      final result = await storage.read<double>(key);

      expect(result, value);
      verify(() => mockPrefs.getDouble(key)).called(1);
    });

    test('should read List<String> value', () async {
      const key = 'test_string_list';
      final value = ['one', 'two', 'three'];
      when(() => mockPrefs.getStringList(key)).thenReturn(value);

      final result = await storage.read<List<String>>(key);

      expect(result, value);
      verify(() => mockPrefs.getStringList(key)).called(1);
    });

    test('should throw UnsupportedError for unsupported type', () async {
      expect(
        () => storage.read<dynamic>('test_map'),
        throwsA(isA<StorageException>()),
      );
    });
  });

  group('write operations', () {
    setUp(() async {
      await storage.init();
    });

    test('should write String value', () async {
      const key = 'test_string';
      const value = 'test_value';
      when(() => mockPrefs.setString(key, value)).thenAnswer((_) async => true);
      when(() => mockPrefs.setString('key', value))
          .thenAnswer((_) async => true);

      final result = await storage.write(key, value);
      //   final result2 = await storage.write('key', value);

      expect(result, true);
      verify(() => mockPrefs.setString(key, value)).called(1);
    });

    test('should write int value', () async {
      const key = 'test_int';
      const value = 42;
      when(() => mockPrefs.setInt(key, value)).thenAnswer((_) async => true);

      final result = await storage.write(key, value);

      expect(result, true);
      verify(() => mockPrefs.setInt(key, value)).called(1);
    });

    test('should throw StateError when write fails', () async {
      const key = 'test_string';
      const value = 'test_value';
      when(() => mockPrefs.setString(key, value))
          .thenAnswer((_) async => false);

      expect(
        () => storage.write(key, value),
        throwsA(isA<StorageException>()),
      );
    });

    test('should write batch values successfully', () async {
      final values = {
        'string_key': 'value',
        'int_key': 42,
        'bool_key': true,
        'double_key': 3.14,
        'list_key': <String>['one', 'two'],
      };

      when(() => mockPrefs.setString('string_key', 'value'))
          .thenAnswer((_) async => true);
      when(() => mockPrefs.setInt('int_key', 42)).thenAnswer((_) async => true);
      when(() => mockPrefs.setBool('bool_key', true))
          .thenAnswer((_) async => true);
      when(() => mockPrefs.setDouble('double_key', 3.14))
          .thenAnswer((_) async => true);
      when(() => mockPrefs.setStringList('list_key', ['one', 'two']))
          .thenAnswer((_) async => true);

      final result = await storage.writeBatch(values);

      expect(result, true);
      verify(() => mockPrefs.setString('string_key', 'value')).called(1);
      verify(() => mockPrefs.setInt('int_key', 42)).called(1);
      verify(() => mockPrefs.setBool('bool_key', true)).called(1);
      verify(() => mockPrefs.setDouble('double_key', 3.14)).called(1);
      verify(() => mockPrefs.setStringList('list_key', ['one', 'two']))
          .called(1);
    });
  });

  group('delete operations', () {
    setUp(() async {
      await storage.init();
    });

    test('should delete key successfully', () async {
      const key = 'test_key';
      when(() => mockPrefs.remove(key)).thenAnswer((_) async => true);

      final result = await storage.delete(key);

      expect(result, true);
      verify(() => mockPrefs.remove(key)).called(1);
    });

    test('should throw StateError when delete fails', () async {
      const key = 'test_key';
      when(() => mockPrefs.remove(key)).thenAnswer((_) async => false);

      expect(
        () => storage.delete(key),
        throwsA(isA<StorageException>()),
      );
    });

    test('should clear all values successfully', () async {
      when(() => mockPrefs.getKeys()).thenReturn({'key1', 'key2'});
      when(() => mockPrefs.clear()).thenAnswer((_) async => true);

      final result = await storage.clear();

      expect(result, true);
      verify(() => mockPrefs.clear()).called(1);
    });
  });

  group('utility operations', () {
    setUp(() async {
      await storage.init();
    });

    test('should check key existence', () async {
      const key = 'test_key';
      when(() => mockPrefs.containsKey(key)).thenReturn(true);

      final result = await storage.has(key);

      expect(result, true);
      verify(() => mockPrefs.containsKey(key)).called(1);
    });

    test('should get storage type correctly', () async {
      const key = 'test_key';
      when(() => mockPrefs.containsKey(key)).thenReturn(true);
      when(() => mockPrefs.get(key)).thenReturn('test_value');

      final result = await storage.getType(key);

      expect(result, StorageType.string);
      verify(() => mockPrefs.containsKey(key)).called(1);
      verify(() => mockPrefs.get(key)).called(1);
    });

    test('should get all keys', () async {
      final keys = {'key1', 'key2', 'key3'};
      when(() => mockPrefs.getKeys()).thenReturn(keys);

      final result = await storage.getKeys();

      expect(result, keys);
      verify(() => mockPrefs.getKeys()).called(1);
    });

    test('should reload storage', () async {
      when(() => mockPrefs.reload()).thenAnswer((_) async {});

      await storage.reload();

      verify(() => mockPrefs.reload()).called(2);
    });
  });
}
