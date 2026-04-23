import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier{

  String appLanguage = 'en' ;

  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    // إذا لم يجد لغة محفوظة، سيستخدم 'en' كافتراضية
    appLanguage = prefs.getString('language') ?? 'en';
    notifyListeners();
  }

  void changeLanguage (String newLanguage){
    if(appLanguage == newLanguage){
      return;
    }
    else{
      appLanguage = newLanguage ;
      notifyListeners();
    }

  }
}