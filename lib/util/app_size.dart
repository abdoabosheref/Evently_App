import 'package:flutter/widgets.dart';

abstract class AppSize {
  static late double width;
  static late double height;


  static void size(BuildContext context) {
    width = MediaQuery.sizeOf(context).width;
    height = MediaQuery.sizeOf(context).height;
  }
}