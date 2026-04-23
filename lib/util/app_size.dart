import 'package:flutter/widgets.dart';

abstract class AppSize {
  static late double width;
  static late double height;


  static void size(BuildContext context) {
    width = MediaQuery.sizeOf(context).width;
    height = MediaQuery.sizeOf(context).height;
  }
}

// import 'package:flutter/material.dart';
//
// extension ContextExt on BuildContext {
//
//   double get width => MediaQuery.sizeOf(this).width;
//
//   double get height => MediaQuery.sizeOf(this).height;
// }

// context.height *
// context.width *
