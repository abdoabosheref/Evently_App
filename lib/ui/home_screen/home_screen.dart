import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/util/app_color_light_dark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../util/app_icon.dart';
import 'home_screen_provider/home_screen_provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    var homeScreenProvider = Provider.of<HomeScreenProvider>(context);

    return Scaffold(
      body: homeScreenProvider.currentTab,
      bottomNavigationBar:
      builtBNB(context: context,
        index: homeScreenProvider.currentIndex,
        onTape: (value) {
          homeScreenProvider.setIndex(value);
        },
      ),
       floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Todo : navigate to add event screen
        },
         child: const Icon(Icons.add, color: AppColorLight.white),

       ));
  }

  BottomNavigationBar builtBNB({required BuildContext context,
    required void Function(int)? onTape,
    required int index,
  }) {
    return BottomNavigationBar(
      onTap: onTape,
      currentIndex: index,
      iconSize: 24,
      selectedIconTheme: IconThemeData(color: AppColorLight.mainColor),
      items: [
        builtBNBItem(
          isSelected: index == 0,
          selected: ColorFilter.mode(AppColorLight.mainColor, .srcIn),
          unSelected: ColorFilter.mode(AppColorLight.disable, .srcIn),
          icon: AppIcon.home,
          label: AppLocalizations.of(context)!.navHome,
        ),

        builtBNBItem(
          isSelected: index == 1,
          selected: ColorFilter.mode(AppColorLight.mainColor, .srcIn),
          unSelected: ColorFilter.mode(AppColorLight.disable, .srcIn),
          icon: AppIcon.heart,
          label: AppLocalizations.of(context)!.navFavorite,
        ),

        builtBNBItem(
          isSelected: index == 2,
          selected: ColorFilter.mode(AppColorLight.mainColor, .srcIn),
          unSelected: ColorFilter.mode(AppColorLight.disable, .srcIn),
          icon: AppIcon.user,
          label: AppLocalizations.of(context)!.navProfile,
        ),
      ],
    );
  }

  BottomNavigationBarItem builtBNBItem({
    required bool isSelected,
    required ColorFilter selected,
    required ColorFilter unSelected,
    required String icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
        colorFilter: isSelected ? selected : unSelected,
        width: 24,
        height: 24,
      ),
      label: label,
    );
  }
}
