import 'package:evently_app/util/app_color_light_dark.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme =ThemeData(
    scaffoldBackgroundColor: AppColorLight.backGround

  );

  static final ThemeData darkTheme =ThemeData(
    scaffoldBackgroundColor: AppColorDark.backGround
  );

}