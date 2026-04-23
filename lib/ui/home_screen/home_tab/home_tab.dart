import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/core/class_model/event_model.dart';
import 'package:evently_app/core/providers/event_list_provider.dart';
import 'package:evently_app/core/providers/theme_provider.dart';
import 'package:evently_app/fire_base_utils.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/util/app_color_light_dark.dart';
import 'package:evently_app/util/app_icon.dart';
import 'package:evently_app/util/app_style_light_dark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/class_model/lists.dart';
import '../../../core/custom_widget/custom_snack_bar.dart';
import '../../../core/providers/user_provider.dart';
import '../../../util/app_routes.dart';
import '../../../util/app_size.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late EventListProvider eventListProvider;
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eventListProvider.addAllEventsFromFireStore(userProvider.currentUser!.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    eventListProvider = Provider.of<EventListProvider>(context);
    userProvider = Provider.of<UserProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    eventListProvider.categoryText(context);

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
            welcomeBackBar(
              themeProvider: themeProvider,
              userProvider: userProvider.currentUser?.name ?? 'guest',
            ),
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
                            eventListProvider.changeSelectedIndex(index,userProvider.currentUser!.id);
                        },
                        child: categoryTabs(
                          itemBuilderIndex: index,
                          themeProvider: themeProvider.isLight(),
                          categoryList: eventListProvider.categoryText(
                            context,
                          )[index],
                          iconsList: ListData.categoryIcons[index],
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10, width: 10),
                      itemCount: eventListProvider.categoryText(context).length,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: eventListProvider.filterEventsList.isEmpty
                  ? Center(
                      child: Text(
                        'no events found',
                        style: AppStyleLight.smb24MainColor,
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemBuilder: (context, index) => eventCard(userProvider: userProvider,
                        themeProvider: themeProvider,
                        event: eventListProvider.filterEventsList[index],
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemCount: eventListProvider.filterEventsList.length,
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
    return eventListProvider.selectedIndex == itemBuilderIndex
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

  Widget eventCard({
    required dynamic themeProvider,
    required EventModel event,required UserProvider userProvider
  }) {
    return InkWell(
      onDoubleTap: () {

        Navigator.pushNamed(context, AppRoutes.eventDetailsScreenRoute,
        arguments: event);
      },
      child: Container(
        width: 343,
        height: 193,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(event.image), fit: .cover),
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
                      DateFormat('d MMM').format(event.eventDate),
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
                            event.title,
                            textAlign: .center,
                            style: themeProvider.isLight()
                                ? AppStyleLight.smb16MainColor
                                : AppStyleDark.smb16MainColor,
                          ),
                          InkWell(
                            onTap: () {
                              eventListProvider.updateIsFavourite(event,userProvider.currentUser!.id);
                              CustomSnackBar.snackBarAlert(
                                context,
                                'Event Updated',
                              );
                            },
                            child: event.isFavourite
                                ? SvgPicture.asset(
                                    AppIcon.heart,
                                    colorFilter: ColorFilter.mode(
                                      AppColorLight.mainColor,
                                      .srcIn,
                                    ),
                                  )
                                : SvgPicture.asset(
                                    AppIcon.heart,
                                    colorFilter: ColorFilter.mode(
                                      AppColorLight.disable,
                                      .srcIn,
                                    ),
                                  ),
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

  Widget welcomeBackBar({
    required dynamic themeProvider,
    required dynamic userProvider,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        AppLocalizations.of(context)!.welcomeBack,
        style: themeProvider.isLight()
            ? AppStyleLight.reg14SecText
            : AppStyleDark.reg14SecText,
      ),
      subtitle: Text(
        userProvider,
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
