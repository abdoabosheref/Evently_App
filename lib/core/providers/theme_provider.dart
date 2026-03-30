import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode appTheme = ThemeMode.light ;

  void changeTheme (ThemeMode newTheme){
    if(appTheme == newTheme){
      return ;
    }
    else{
      appTheme = newTheme ;
      notifyListeners();
    }
  }
  bool isLight(){
    return appTheme == ThemeMode.light ;
  }
}