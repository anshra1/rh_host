import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/theme/theme_storage.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    _loadSavedPreferences();
    // Use PlatformDispatcher instead of window
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
        notifyListeners;
  }

  @override
  void dispose() {
    // Clean up the brightness listener
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = null;
    super.dispose();
  }

  ThemeMode _currentMode = ThemeMode.system;
  bool _useSeedColors = false;

  ThemeMode get currentMode => _currentMode;
  bool get useSeedColors => _useSeedColors;

  bool get isDarkMode {
    if (_currentMode == ThemeMode.system) {
      // Use platformDispatcher instead of window
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      debugPrint('System brightness: $brightness');
      return brightness == Brightness.dark;
    }
    return _currentMode == ThemeMode.dark;
  }

  Future<void> _loadSavedPreferences() async {
    final (savedMode, savedUseSeed) = await ThemeStorage.loadThemePreferences();

    _currentMode = ThemeMode.values.firstWhere(
      (mode) => mode.name == savedMode,
      orElse: () => ThemeMode.system,
    );
    _useSeedColors = savedUseSeed;
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_currentMode == mode) return;
    debugPrint('Setting theme mode to: ${mode.name}');
    _currentMode = mode;
    await ThemeStorage.saveThemeMode(mode.name);
    notifyListeners();
  }

  Future<void> toggleSeedColors() async {
    _useSeedColors = !_useSeedColors;
    await ThemeStorage.saveUseSeedColors(_useSeedColors);
    notifyListeners();
  }
}
