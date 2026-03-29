import 'package:evently_app/util/app_color_light_dark.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColorLight.backGround,
    colorScheme: ColorScheme.light(primaryContainer: AppColorLight.white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColorLight.white,
      selectedItemColor: AppColorLight.mainColor,
      unselectedItemColor: AppColorLight.disable,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColorDark.backGround,
    colorScheme: ColorScheme.dark(primaryContainer: AppColorDark.inputs),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColorDark.backGround,
        selectedItemColor: AppColorDark.mainColor,
        unselectedItemColor: AppColorDark.disable,
  ));
}
