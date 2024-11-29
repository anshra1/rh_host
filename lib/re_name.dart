import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rh_host/src/core/config/keyboard.dart';
import 'package:rh_host/src/core/routes/import.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, ch) => DismissKeyboard(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'library-app',
          //theme: MyTheme.lightTheme,
          themeMode: ThemeMode.light,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
