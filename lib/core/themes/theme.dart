import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:habits_tracker/core/themes/palette.dart';

/// Main application theme
final class MyTheme {
  static final ThemeData baseTheme = ThemeData(
    fontFamily: 'Nunito',
    fontFamilyFallback: const ['Roboto'],
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
    iconTheme: const IconThemeData(color: Palette.black, size: 16.0),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Palette.black, size: 16.0),
      titleTextStyle: TextStyle(
        fontSize: 18.0,
        color: Palette.black,
        fontFamily: 'Nunito',
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Palette.lightGrey,
        statusBarBrightness: Brightness.light,
      ),
    ),
    scaffoldBackgroundColor: Palette.lightGrey,
    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: Palette.lightGreenSalad,
      indicatorColor: Palette.lightGreenSalad,
      unselectedLabelColor: Palette.grey,
      dividerColor: Palette.lightGreenSalad,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      suffixIconColor: Palette.black,
      floatingLabelStyle: TextStyle(color: Palette.green),
      enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Palette.lightGreenSalad, width: 1),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Palette.lightGreenSalad, width: 2),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Palette.red, width: 2),
      ),
      errorStyle: TextStyle(fontSize: 14.0),
      focusColor: Palette.black,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Palette.lightGreenSalad,
    ),
  );
}
