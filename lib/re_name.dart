// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:rh_host/src/core/design_system/base/app_theme.dart';
import 'package:rh_host/src/core/services/config/keyboard.dart';
import 'package:rh_host/src/core/services/routes/import.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => DismissKeyboard(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'library-app',
          theme: AppTheme.light,
          themeMode: ThemeMode.light,
          routerConfig: AppRouter.router,
          // App-wide configurations
          builder: (context, child) {
            // Apply any app-wide configurations like text scaling
            return MediaQuery(
              // Prevent text scaling from device settings
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.noScaling),
              child: child!,
            );
          },
        ),
      ),
    );
  }
}
