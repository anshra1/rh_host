// // lib/src/core/storage/storage_manager.dart

// import 'package:rh_host/src/core/storage/app_storage.dart';
// import 'package:rh_host/src/core/storage/pre_app_storage.dart';
// import 'package:rh_host/src/core/storage/storage_keys.dart';

// class StorageManager {
//   StorageManager._({
//     required this.storage,
//     this.config = const StorageConfig(),
//   });

//   static StorageManager? _instance;
//   final AppStorage storage;
//   final StorageConfig config;

//   // static Future<StorageManager> getInstance() async {
//   //   if (_instance == null) {
//   //     final storage = await SharedPrefsStorage.getInstance();
//   //     _instance = StorageManager._(
//   //      // storage: storage,
//   //       config: const StorageConfig(),
//   //     );
//   //   }
//   //   return _instance!;
//   // }

//   // Version control
//   static const String _versionKey = 'storage_version';
//   static const int currentVersion = 1;

//   // Cache management
//   final _cache = <String, _CacheEntry>{};

//   Future<void> initialize() async {
//     await _runMigrations();
//     await _cleanExpiredData();
//   }

//   Future<T?> getValue<T>(String key) async {
//     // Check cache first
//     if (config.enableCache) {
//       final cachedValue = _getCachedValue<T>(key);
//       if (cachedValue != null) return cachedValue;
//     }

//     final value = await storage.read<T>(key);

//     // Update cache
//     if (config.enableCache && value != null) {
//       _cache[key] = _CacheEntry(
//         value: value,
//         timestamp: DateTime.now(),
//       );
//     }

//     return value;
//   }

//   Future<bool> setValue<T>(String key, T value) async {
//     final result = await storage.write(key, value);

//     if (result && config.enableCache) {
//       _cache[key] = _CacheEntry(
//         value: value,
//         timestamp: DateTime.now(),
//       );
//     }

//     return result;
//   }

//   Future<void> _runMigrations() async {
//     final version = await storage.read<int>(_versionKey) ?? 0;

//     if (version < currentVersion) {
//       await _migrate(version);
//       await storage.write(_versionKey, currentVersion);
//     }
//   }

//   Future<void> _migrate(int fromVersion) async {
//     switch (fromVersion) {
//       case 0:
//         await _migrateV0ToV1();
//       // Add more cases as your app evolves
//     }
//   }

//   Future<void> _migrateV0ToV1() async {
//     // Example migration
//     final oldTheme = await storage.read<String>('theme');
//     if (oldTheme != null) {
//       await storage.write(StorageKeys.theme, oldTheme);
//       await storage.delete('theme');
//     }
//   }

//   Future<void> _cleanExpiredData() async {
//     final now = DateTime.now();
//     final keys = await storage.getKeys();

//     for (final key in keys) {
//       final ttl = StorageKeys.ttls[key];
//       if (ttl != null) {
//         final timestamp = await storage.read<String>('${key}_timestamp');
//         if (timestamp != null) {
//           final storedDate = DateTime.parse(timestamp);
//           if (now.difference(storedDate) > ttl) {
//             await storage.delete(key);
//             await storage.delete('${key}_timestamp');
//             _cache.remove(key);
//           }
//         }
//       }
//     }
//   }

//   T? _getCachedValue<T>(String key) {
//     final entry = _cache[key];
//     if (entry == null) return null;

//     if (DateTime.now().difference(entry.timestamp) > config.cacheDuration) {
//       _cache.remove(key);
//       return null;
//     }

//     return entry.value as T?;
//   }

//   // Batch operations with cache support
//   Future<bool> setValues(Map<String, dynamic> values) async {
//     final result = await storage.writeBatch(values);

//     if (result && config.enableCache) {
//       for (final entry in values.entries) {
//         _cache[entry.key] = _CacheEntry(
//           value: entry.value,
//           timestamp: DateTime.now(),
//         );
//       }
//     }

//     return result;
//   }

//   // Clear cache
//   void clearCache() {
//     _cache.clear();
//   }

//   // Cache specific keys
//   Future<void> cacheKeys(List<String> keys) async {
//     for (final key in keys) {
//       final value = await storage.read(key);
//       if (value != null) {
//         _cache[key] = _CacheEntry(
//           value: value,
//           timestamp: DateTime.now(),
//         );
//       }
//     }
//   }

//   // Storage metrics
//   Future<StorageMetrics> getMetrics() async {
//     final keys = await storage.getKeys();
//     final cacheHits = _cacheHits;
//     final cacheMisses = _cacheMisses;

//     return StorageMetrics(
//       totalKeys: keys.length,
//       cacheSize: _cache.length,
//       cacheHitRate: cacheHits / (cacheHits + cacheMisses),
//     );
//   }

//   int _cacheHits = 0;
//   int _cacheMisses = 0;
// }

// class _CacheEntry {
//   final dynamic value;
//   final DateTime timestamp;

//   _CacheEntry({
//     required this.value,
//     required this.timestamp,
//   });
// }

// class StorageConfig {
//   final bool enableCache;
//   final Duration cacheDuration;
//   final bool enableMetrics;
//   final bool enableMigrations;

//   const StorageConfig({
//     this.enableCache = true,
//     this.cacheDuration = const Duration(minutes: 30),
//     this.enableMetrics = false,
//     this.enableMigrations = true,
//   });
// }

// class StorageMetrics {
//   final int totalKeys;
//   final int cacheSize;
//   final double cacheHitRate;

//   StorageMetrics({
//     required this.totalKeys,
//     required this.cacheSize,
//     required this.cacheHitRate,
//   });
// }

// // Usage example:
// void main() async {
//   final manager = await StorageManager.getInstance();
//   await manager.initialize();

//   // Simple operations
//   await manager.setValue('key', 'value');
//   final value = await manager.getValue<String>('key');

//   // Batch operations
//   await manager.setValues({
//     'theme': 'dark',
//     'notifications': true,
//     'language': 'en',
//   });

//   // Get metrics
//   final metrics = await manager.getMetrics();
//   print('Cache hit rate: ${metrics.cacheHitRate}');

//   // Cache specific keys for better performance
//   await manager.cacheKeys([
//     StorageKeys.theme,
//     StorageKeys.locale,
//   ]);
// }
