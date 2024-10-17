import 'package:flutter/material.dart';

mixin Font {
  static FontWeight get l => FontWeight.w300;
  static FontWeight get n => FontWeight.w400;
  static FontWeight get sb => FontWeight.w600;
  static FontWeight get b => FontWeight.w700;
}

class AppTextStyle {
  static TextStyle get header => TextStyle(
        fontSize: 24,
        fontWeight: Font.b,
        color: Colors.black,
      );

  static TextStyle get subheader => TextStyle(
        fontSize: 20,
        fontWeight: Font.sb,
        color: Colors.grey,
      );

  static TextStyle get body => TextStyle(
        fontSize: 16,
        fontWeight: Font.n,
        color: Colors.black87,
      );
}

class Typography {
  // Base text styles
  static const _baseTextStyle = TextStyle(
    fontFamily: 'Roboto',
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );

  // Heading styles
  static final h1 = _baseTextStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.5,
  );

  static final h2 = _baseTextStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
  );

  // Body text styles
  static final bodyLarge = _baseTextStyle.copyWith(
    fontSize: 16,
    height: 1.5,
  );

  static final bodyMedium = _baseTextStyle.copyWith(
    fontSize: 14,
    height: 1.4,
  );

  // Button text style
  static final button = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  );
}

@immutable
class CustomTextTheme extends ThemeExtension<CustomTextTheme> {
  const CustomTextTheme({
    required this.caption,
    required this.subtitle,
  });

  final TextStyle caption;
  final TextStyle subtitle;

  @override
  CustomTextTheme copyWith({
    TextStyle? caption,
    TextStyle? subtitle,
  }) {
    return CustomTextTheme(
      caption: caption ?? this.caption,
      subtitle: subtitle ?? this.subtitle,
    );
  }

  @override
  CustomTextTheme lerp(CustomTextTheme? other, double t) {
    if (other is! CustomTextTheme) return this;
    return CustomTextTheme(
      caption: TextStyle.lerp(caption, other.caption, t)!,
      subtitle: TextStyle.lerp(subtitle, other.subtitle, t)!,
    );
  }
}

// 2. Define your app's theme
ThemeData appTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
      bodyMedium: TextStyle(fontSize: 14, fontFamily: 'Hind'),
      displaySmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
    extensions: const [
      CustomTextTheme(
        caption: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
        subtitle:
            TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      ),
    ],
  );
}
