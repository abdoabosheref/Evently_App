import 'package:evently_app/core/providers/theme_provider.dart';
import 'package:evently_app/util/app_color_light_dark.dart';
import 'package:evently_app/util/app_style_light_dark.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class CustomAlertDialog {
  static void showAlert({
    required BuildContext context,
    String title = '',
    String content = '',
    required List<Widget> actions,
  }) {
    var themeProvider = Provider.of<ThemeProvider>(context,listen: false);

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          titleTextStyle: themeProvider.isLight()
              ? AppStyleLight.med18MainColor
              : AppStyleDark.med18White,
          backgroundColor: themeProvider.isLight()
              ? AppColorLight.backGround
              : AppColorDark.backGround,

          actions: actions,
        );
      },
    );
  }
}
