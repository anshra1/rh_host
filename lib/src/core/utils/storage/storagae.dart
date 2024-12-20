// //lib/src/design/utils/storage/storage_service.dart
// abstract class StorageService {
//   Future<void> init();
//   Future<void> clear();

//   Future<void> setString(String key, String value);
//   Future<String?> getString(String key);

//   Future<void> setInt(String key, int value);
//   Future<int?> getInt(String key);

//   Future<void> setBool(String key, bool value);
//   Future<bool?> getBool(String key);

//   Future<void> setDouble(String key, double value);
//   Future<double?> getDouble(String key);

//   Future<void> setStringList(String key, List<String> value);
//   Future<List<String>?> getStringList(String key);

//   Future<void> remove(String key);
//   Future<bool> containsKey(String key);
// }

// class SharedPrefsService implements StorageService {
//   SharedPrefsService._();
//   static SharedPrefsService? _instance;
//   static SharedPreferences? _prefs;

//   static Future<SharedPrefsService> getInstance() async {
//     _instance ??= SharedPrefsService._();
//     _prefs ??= await SharedPreferences.getInstance();
//     return _instance!;
//   }

//   @override
//   Future<void> init() async {
//     _prefs ??= await SharedPreferences.getInstance();
//   }

//   @override
//   Future<void> clear() async {
//     await _prefs?.clear();
//   }

//   @override
//   Future<void> setString(String key, String value) async {
//     await _prefs?.setString(key, value);
//   }

//   @override
//   Future<String?> getString(String key) async {
//     return _prefs?.getString(key);
//   }

//   @override
//   Future<void> setInt(String key, int value) async {
//     await _prefs?.setInt(key, value);
//   }

//   @override
//   Future<int?> getInt(String key) async {
//     return _prefs?.getInt(key);
//   }

//   @override
//   Future<void> setBool(String key, bool value) async {
//     await _prefs?.setBool(key, value);
//   }

//   @override
//   Future<bool?> getBool(String key) async {
//     return _prefs?.getBool(key);
//   }

//   @override
//   Future<void> setDouble(String key, double value) async {
//     await _prefs?.setDouble(key, value);
//   }

//   @override
//   Future<double?> getDouble(String key) async {
//     return _prefs?.getDouble(key);
//   }

//   @override
//   Future<void> setStringList(String key, List<String> value) async {
//     await _prefs?.setStringList(key, value);
//   }

//   @override
//   Future<List<String>?> getStringList(String key) async {
//     return _prefs?.getStringList(key);
//   }

//   @override
//   Future<void> remove(String key) async {
//     await _prefs?.remove(key);
//   }

//   @override
//   Future<bool> containsKey(String key) async {
//     return _prefs?.containsKey(key) ?? false;
//   }
// }

// // lib/src/design/utils/storage/cache_service.dart
// class CacheService {
//   CacheService({
//     this.maxSize = 100,
//     this.defaultTTL = const Duration(minutes: 30),
//   });

//   final int maxSize;
//   final Duration defaultTTL;
//   final _cache = <String, CacheEntry>{};
//   final _accessOrder = LinkedHashMap<String, int>();
//   final int _accessCount = 0;

//   T? get<T>(String key) {
//     final entry = _cache[key];
//     if (entry == null || entry.isExpired) {
//       _cache.remove(key);
//       _accessOrder.remove(key);
//       return null;
//     }

//     _updateAccessOrder(key);
//     return entry.value as T;
//   }

//   void set<T>(
//     String key,
//     T value, {
//     Duration? ttl,
//   }) {
//     if (_cache.length >= maxSize && !_cache.containsKey(key)) {
//       _evictLeastRecentlyUsed();
//     }

//     _cache[key] = CacheEntry(
//       value: value,
//       expiryTime: DateTime.now().add(tt