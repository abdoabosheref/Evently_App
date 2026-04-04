import 'package:flutter/cupertino.dart';
import '../../ui/home_screen/fav_tab/fav_tab.dart';
import '../../ui/home_screen/home_tab/home_tab.dart';
import '../../ui/home_screen/profile_tab/profile_tab.dart';


class HomeScreenProvider extends ChangeNotifier{

  int currentIndex = 0 ;

  List<Widget> tabsList = [HomeTab(),FavTab(),ProfileTab()];
  late var currentTab = tabsList[currentIndex] ;


  void setIndex (int newIndex){
    currentIndex = newIndex;
    currentTab = tabsList[currentIndex] ;
    notifyListeners();
  }

}




