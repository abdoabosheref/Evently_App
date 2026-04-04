import 'package:evently_app/core/providers/theme_provider.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/util/app_color_light_dark.dart';
import 'package:evently_app/util/app_icon.dart';
import 'package:evently_app/util/app_image.dart';
import 'package:evently_app/util/app_style_light_dark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../util/app_size.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    //todo : app size width * height =  375 *  812

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

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: AppSize.height * 0.04,
          right: AppSize.width * 0.04,
          left: AppSize.width * 0.04,
        ),
        child: Column(
          children: [
            SizedBox(height: AppSize.height * 0.02),
            welcomeBackBar(themeProvider: themeProvider),
            SizedBox(height: AppSize.height * 0.02),
            Row(
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
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) =>
                    eventCard(themeProvider: themeProvider),
                separatorBuilder: (context, index) => SizedBox(height: 16),
                itemCount: 2,
              ),
            ),
          ],
        ),
      ),
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

  Widget eventCard({required dynamic themeProvider}) {
    return InkWell(
      onDoubleTap: () {
        //Todo : details page with add & delete button
      },
      child: Container(
        width: 343,
        height: 193,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              themeProvider.isLight()
                  ? AppImage.exhibitionLight
                  : AppImage.exhibitionDark,
            ),
            fit: .cover,
          ),
          border: BoxBorder.all(
            width: 2,
            color: themeProvider.isLight()
                ? AppColorLight.stroke
                : AppColorDark.stroke,
          ),
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),

        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: .spaceBetween,
                crossAxisAlignment: .start,
                children: [
                  Container(
                    alignment: .center,
                    width: AppSize.width * 0.17,
                    height: AppSize.height * 0.055,
                    decoration: BoxDecoration(
                      border: BoxBorder.all(
                        color: themeProvider.isLight()
                            ? AppColorLight.stroke
                            : AppColorDark.stroke,
                      ),
                      color: themeProvider.isLight()
                          ? AppColorLight.backGround
                          : AppColorDark.backGround,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '21 JAN',
                      style: themeProvider.isLight()
                          ? AppStyleLight.smb16MainColor
                          : AppStyleDark.smb16MainColor,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: AppSize.height * 0.05,
                    decoration: BoxDecoration(
                      border: BoxBorder.all(
                        color: themeProvider.isLight()
                            ? AppColorLight.stroke
                            : AppColorDark.stroke,
                      ),
                      color: themeProvider.isLight()
                          ? AppColorLight.backGround
                          : AppColorDark.backGround,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Text(
                            '21 JAN',
                            textAlign: .center,
                            style: themeProvider.isLight()
                                ? AppStyleLight.smb16MainColor
                                : AppStyleDark.smb16MainColor,
                          ),
                          InkWell(
                            onTap: () {
                              //Todo : add to favTab + change icon color
                            },
                            child: SvgPicture.asset(AppIcon.heart),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget welcomeBackBar({required dynamic themeProvider}) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        AppLocalizations.of(context)!.welcomeBack,
        style: themeProvider.isLight()
            ? AppStyleLight.reg14SecText
            : AppStyleDark.reg14SecText,
      ),
      subtitle: Text(
        'Abdo Mohamed',
        style: themeProvider.isLight()
            ? AppStyleLight.med20MainText
            : AppStyleDark.med20White,
      ),
      trailing: Row(
        mainAxisSize: .min,
        spacing: AppSize.width * 0.01,
        children: [
          themeProvider.isLight()
              ? SvgPicture.asset(AppIcon.sunOutline)
              : SvgPicture.asset(AppIcon.moon),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: themeProvider.isLight()
                  ? AppColorLight.mainColor
                  : AppColorDark.mainColor,
            ),

            width: AppSize.width * 0.09,
            height: AppSize.height * 0.04,
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.en,
                style: AppStyleLight.smb14White,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
