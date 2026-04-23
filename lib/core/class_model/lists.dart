import 'package:flutter/cupertino.dart';

import '../../l10n/app_localizations.dart';
import '../../util/app_icon.dart';
import '../../util/app_image.dart';

abstract class ListData {


 static   List<String> addEventCategoryText (BuildContext context){
     return [
       AppLocalizations.of(context)!.categorySport,
       AppLocalizations.of(context)!.categoryBirthday,
       AppLocalizations.of(context)!.categoryBookClub,
       AppLocalizations.of(context)!.categoryExhibition,
       AppLocalizations.of(context)!.categoryMeeting,
     ];
   }
 static const List<String> categoryIcons = [
    AppIcon.square,
    AppIcon.bike,
    AppIcon.cake,
    AppIcon.books,
    AppIcon.books,
    AppIcon.books,
    //todo : add icons for meeting and exhibition
  ];
 static const List<String> addEventCategoryIcons = [
    AppIcon.bike,
    AppIcon.cake,
    AppIcon.books,
    AppIcon.books,
    AppIcon.books,
    //todo : add icons for meeting and exhibition
  ];
  static const List<String>eventImageLightList =[
    AppImage.sportLight,
    AppImage.birthdayLight,
    AppImage.bookClubLight,
    AppImage.exhibitionLight,
    AppImage.meetingLight,

  ];
  static const List<String>eventImageDarkList =[
    AppImage.sportDark,
    AppImage.birthdayDark,
    AppImage.bookClubDark,
    AppImage.exhibitionDark,
    AppImage.meetingDark,

  ];

}