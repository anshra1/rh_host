import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rh_host/src/core/design_system/theme/theme_provider.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Material 3 Seed Colors Toggle
        SwitchListTile(
          title: const Text('Use Material 3 Colors'),
          subtitle: const Text('Enable dynamic color scheme'),
          value: themeProvider.useSeedColors,
          onChanged: (_) => themeProvider.toggleSeedColors(),
        ),

        const Divider(),

        // Theme Mode Selection
        ListTile(
          title: const Text('Theme Mode'),
          subtitle: Text(themeProvider.currentMode.name.toUpperCase()),
        ),
        RadioListTile<ThemeMode>(
          title: const Text('System'),
          value: ThemeMode.system,
          groupValue: themeProvider.currentMode,
          onChanged: (mode) {
            if (mode != null) themeProvider.setThemeMode(mode);
          },
        ),
        RadioListTile<ThemeMode>(
          title: const Text('Light'),
          value: ThemeMode.light,
          groupValue: themeProvider.currentMode,
          onChanged: (mode) {
            if (mode != null) themeProvider.setThemeMode(mode);
          },
        ),
        RadioListTile<ThemeMode>(
          title: const Text('Dark'),
          value: ThemeMode.dark,
          groupValue: themeProvider.currentMode,
          onChanged: (mode) {
            if (mode != null) themeProvider.setThemeMode(mode);
          },
        ),
      ],
    );
  }
}
