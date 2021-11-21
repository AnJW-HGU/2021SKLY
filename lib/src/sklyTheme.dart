import 'package:flutter/material.dart';

class SKLYTheme {
  static const _lightFillColor = Color(0xffffffff);

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);

  static ThemeData lightThemeData =
  themeData(lightColorScheme, _lightFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      // fontFamily: '',
      // textTheme: _textTheme.apply(
      //     displayColor: Color(0xff343434), fontFamily: GoogleFonts
      //     .roboto()
      //     .fontFamily),
      // Matches manifest.json colors and background color.
      primaryColor: colorScheme.primary,
      appBarTheme: AppBarTheme(
        textTheme: _textTheme.apply(bodyColor: colorScheme.onPrimary),
        color: colorScheme.background,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
        brightness: colorScheme.brightness,
      ),
      backgroundColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme().copyWith(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          )
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary,),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      accentColor: colorScheme.primary,
      focusColor: focusColor,
      buttonTheme: ButtonThemeData(
        disabledColor: Color(0x33000000),
      ),
      disabledColor: Colors.white,
      dividerColor: Color(0xffdbdbdb),
      dividerTheme: DividerThemeData(
        thickness: 1.0,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colorScheme.primary
      ),

    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
      primary: Color(0xff2A3F6A),
      primaryVariant: Color(0xff8CA1B4),
      secondary: Color(0xffE8A93F),
      secondaryVariant: Color(0xffE8A93F),
      surface: Color.fromRGBO(255, 255, 255, 0.74),
      background: Color(0xffF5F6FA),
      error: Color(0xffb00020),
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Color.fromRGBO(0, 0, 0, 0.12),
      onBackground: Colors.black,
      onError: Colors.white,
      brightness: Brightness.light);
  static final TextTheme _textTheme = Typography.blackCupertino;
}