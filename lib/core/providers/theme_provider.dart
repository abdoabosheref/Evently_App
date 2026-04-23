import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode appTheme = ThemeMode.light ;

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    // نقرأ القيمة كـ bool (true للـ Dark و false للـ Light)
    bool isDark = prefs.getBool('isDark') ?? false;
    appTheme = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
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