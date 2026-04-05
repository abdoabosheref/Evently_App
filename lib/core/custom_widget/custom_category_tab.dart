import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../util/app_color_light_dark.dart';
import '../../util/app_icon.dart';
import '../../util/app_size.dart';
import '../../util/app_style_light_dark.dart';
import '../providers/theme_provider.dart';

class CustomCategoryTab extends StatefulWidget {
   CustomCategoryTab({super.key});

  @override
  State<CustomCategoryTab> createState() => _CustomCategoryTabState();
}

class _CustomCategoryTabState extends State<CustomCategoryTab> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    List<String> categoryText = [
      AppLocalizations.of(context)!.categoryAll,
      AppLocalizations.of(context)!.categorySport,
      AppLocalizations.of(context)!.categoryBirthday,
      AppLocalizations.of(context)!.categoryBookClub,
      AppLocalizations.of(context)!.categoryExhibition,
      AppLocalizations.of(context)!.categoryMeeting,
    ];
    List<String> categoryIcons = [
      AppIcon.square,
      AppIcon.bike,
      AppIcon.cake,
      AppIcon.books,
      AppIcon.books,
      AppIcon.books,
      //todo : add icons for meeting and exhibition
    ];
    return  Row(
      children: [
        Expanded(
          child: SizedBox(
            height: AppSize.height * 0.04,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  selectedIndex = index;
                  setState(() {
                    //Todo : tabs Filter List view
                  });
                },
                child: categoryTabs(
                  itemBuilderIndex: index,
                  themeProvider: themeProvider.isLight(),
                  categoryList: categoryText[index],
                  iconsList: categoryIcons[index],
                ),
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(height: 10, width: 10),
              itemCount: categoryText.length,
            ),
          ),
        ),
      ],
    );
  }
  Widget categoryTabs({
    required int itemBuilderIndex,
    required bool themeProvider,
    var iconsList,
    var categoryList,
  }) {
    return selectedIndex == itemBuilderIndex
        ? Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.width * 0.04,
        vertical: AppSize.height * 0.001,
      ),
      decoration: BoxDecoration(
        color: themeProvider
            ? AppColorLight.mainColor
            : AppColorDark.mainColor,
        borderRadius: BorderRadius.circular(16),
      ),
      height: AppSize.height * 0.04,
      child: Row(
        spacing: AppSize.width * 0.02,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconsList,
            colorFilter: themeProvider
                ? ColorFilter.mode(AppColorLight.white, .srcIn)
                : ColorFilter.mode(AppColorDark.white, .srcIn),
          ),
          Text(
            categoryList,
            style: themeProvider
                ? AppStyleLight.med16White
                : AppStyleDark.med16White,
          ),
        ],
      ),
    )
        : Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.width * 0.04,
        vertical: AppSize.height * 0.001,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      height: AppSize.height * 0.04,
      child: Row(
        spacing: AppSize.width * 0.02,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconsList,
            colorFilter: themeProvider
                ? ColorFilter.mode(AppColorLight.mainColor, .srcIn)
                : ColorFilter.mode(AppColorDark.mainColor, .srcIn),
          ),
          Text(
            categoryList,
            style: themeProvider
                ? AppStyleLight.med16MainText
                : AppStyleDark.med16White,
          ),
        ],
      ),
    );
  }
}
