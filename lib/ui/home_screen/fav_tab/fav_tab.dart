import 'package:evently_app/core/providers/user_provider.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/util/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/class_model/event_model.dart';
import '../../../core/custom_widget/custom_snack_bar.dart';
import '../../../core/custom_widget/custom_text_form_field.dart';
import '../../../core/providers/event_list_provider.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../util/app_color_light_dark.dart';
import '../../../util/app_icon.dart';
import '../../../util/app_routes.dart';
import '../../../util/app_style_light_dark.dart';


class FavTab extends StatefulWidget {
  const FavTab({super.key});

  @override
  State<FavTab> createState() => _FavTabState();
}

class _FavTabState extends State<FavTab> {
  late EventListProvider eventListProvider ;
  late UserProvider userProvider ;
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
        eventListProvider.getAllFavouriteEvents(userProvider.currentUser!.id);
      },
    );

  }
  @override
  Widget build(BuildContext context) {
    userProvider =  Provider.of<UserProvider>(context);
    eventListProvider = Provider.of<EventListProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: AppSize.height * 0.01),
              CustomTextFormField(
                rightIcon: Icon(
                  Icons.search,
                  size: 30,
                  color: themeProvider.isLight()
                      ? AppColorLight.mainColor
                      : AppColorDark.white,
                ),
                hintText: AppLocalizations.of(context)!.searchHint,
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  //Todo ; search or fav events
                },
              ),
              Expanded(
                child: eventListProvider.favouriteList.isEmpty
                    ? Center(
                  child: Text(
                    'no events found',
                    style: AppStyleLight.smb24MainColor,
                  ),
                )
                    : ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemBuilder: (context, index) => eventCard(
                    themeProvider: themeProvider,
                    event: eventListProvider.favouriteList[index],
                  ),
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemCount: eventListProvider.favouriteList.length,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget eventCard({required dynamic themeProvider ,required EventModel event}) {
    return InkWell(
      onDoubleTap: () {
        Navigator.pushNamed(context, AppRoutes.eventDetailsScreenRoute);
      },
      child: Container(
        width: 343,
        height: 193,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                event.image
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
                                CustomSnackBar.snackBarAlert(context, 'Event Removed from Favourite');
                              },
                              child:event.isFavourite
                                  ? SvgPicture.asset(AppIcon.heart,
                                colorFilter: ColorFilter.mode(AppColorLight.mainColor, .srcIn),)
                                  : SvgPicture.asset(AppIcon.heart,
                                colorFilter: ColorFilter.mode(AppColorLight.disable, .srcIn),)),
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
}
