import 'package:evently_app/util/app_color_light_dark.dart';
import 'package:evently_app/util/app_size.dart';
import 'package:evently_app/util/app_style_light_dark.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColorLight.backGround,
    colorScheme: ColorScheme.light(primaryContainer: AppColorLight.white,
    primaryFixed: AppColorLight.stroke,),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColorLight.white,
      selectedItemColor: AppColorLight.mainColor,
      unselectedItemColor: AppColorLight.disable,
      type: BottomNavigationBarType.fixed,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColorLight.mainColor,
      shape: CircleBorder(),
      iconSize: 24,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: AppStyleLight.med20White,
        elevation: 0,
        foregroundColor: AppColorLight.white,
        backgroundColor: AppColorLight.mainColor,
        minimumSize: Size(double.infinity, AppSize.height * 0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
    dividerTheme: DividerThemeData(thickness: 2, color: AppColorLight.stroke),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: AppStyleLight.smb14MainColor.copyWith(
          decoration: TextDecoration.underline,
          color: AppColorLight.mainColor,
        ),
        foregroundColor: AppColorLight.mainColor,
      ),
    ),
    appBarTheme: AppBarThemeData(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColorLight.mainText,
      titleTextStyle: AppStyleLight.med18MainText,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(padding: EdgeInsets.zero,
          backgroundColor: AppColorLight.white,
          shape: RoundedRectangleBorder(side: BorderSide(
            color: AppColorLight.stroke
          ),borderRadius: BorderRadius.circular(8))
    )

    ),

  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColorDark.backGround,
    colorScheme: ColorScheme.dark(primaryContainer: AppColorDark.inputs,
      primaryFixed: AppColorDark.stroke,),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColorDark.backGround,
      selectedItemColor: AppColorDark.mainColor,
      unselectedItemColor: AppColorDark.disable,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColorDark.mainColor,
      shape: CircleBorder(),
      iconSize: 24,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: AppStyleLight.med20White,
        elevation: 0,
        foregroundColor: AppColorLight.white,
        backgroundColor: AppColorLight.mainColor,
        minimumSize: Size(double.infinity, AppSize.height * 0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
    dividerTheme: DividerThemeData(thickness: 2, color: AppColorDark.stroke),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: AppStyleLight.smb14MainColor.copyWith(
          decoration: TextDecoration.underline,
          color: AppColorDark.mainColor,
        ),
        foregroundColor: AppColorDark.mainColor,
      ),
    ),
    appBarTheme: AppBarThemeData(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColorDark.white,
      titleTextStyle: AppStyleDark.med18White,
    ),
    iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(padding: EdgeInsets.zero,
            backgroundColor: AppColorDark.backGround,
            shape: RoundedRectangleBorder(side: BorderSide(
                color: AppColorDark.stroke
            ),borderRadius: BorderRadius.circular(8))
        )

    ),

  );
}
