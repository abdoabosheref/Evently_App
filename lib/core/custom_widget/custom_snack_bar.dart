import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {

 static  void snackBarAlert(BuildContext context , String text){

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar( backgroundColor: Colors.green,
      content: Text(text),));
  }


}