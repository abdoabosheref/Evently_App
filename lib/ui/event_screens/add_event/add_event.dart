import 'package:evently_app/core/custom_widget/custom_app_bar.dart';
import 'package:evently_app/core/custom_widget/custom_category_tab.dart';
import 'package:evently_app/core/custom_widget/custom_elevated_button.dart';
import 'package:evently_app/core/custom_widget/custom_text_form_field.dart';
import 'package:evently_app/util/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../core/custom_widget/custom_events_image_box.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../util/app_color_light_dark.dart';
import '../../../util/app_icon.dart';
import '../../../util/app_routes.dart';
import '../../../util/app_size.dart';
import '../../../util/app_style_light_dark.dart';

class AddEvent extends StatefulWidget {
   AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {

  @override
  Widget build(BuildContext context) {
var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: PreferredSize(preferredSize:  Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
              onTap: ()=> Navigator.pop(context,AppRoutes.homeScreenRoute),
              appLocalText: AppLocalizations.of(context)!.addEventText,
              showModifiedActionButtons: false,
          onTapDelete: (){},
          onTapEdit: (){},)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:AppSize.width* 0.04,
        vertical: AppSize.height*0.02),
        child: Column(
          spacing: AppSize.height*0.01,
          children: [
            CustomEventsImageBox( imagePathInLight: AppImage.meetingLight,
            imagePathInDark: AppImage.meetingDark,),
            CustomCategoryTab(),
            Align(alignment: .centerLeft,
              child: Text('Title',style:themeProvider.isLight()
                  ? AppStyleLight.med16MainText
                  :AppStyleDark.med16White,),
            ),
            CustomTextFormField(hintText: "Event Title",
              onChanged: (value) {},),
            Align(alignment: .centerLeft,
              child: Text('Description',style:themeProvider.isLight()
                  ? AppStyleLight.med16MainText
                  :AppStyleDark.med16White,),
            ),
            CustomTextFormField(hintText: "Event Description....",
              maxLines: 7,
              onChanged: (value) {},),
            builtListTile(icon: AppIcon.calender,
                themeProvider: themeProvider,
                title: 'Event Date',
                textButtonTitle: 'Choose Date',
                TextButtonOnTap: () { }),
            builtListTile(icon: AppIcon.clock,
                themeProvider: themeProvider,
                title: 'Event Time',
                textButtonTitle: 'Choose Time',
                TextButtonOnTap: () { }),
            CustomElevatedButton(
                appLocalText:AppLocalizations.of(context)!.addEventText,
                onTap: () {
                  Navigator.pushNamed(context,AppRoutes.eventDetailsScreenRoute);

                },
                switchButtonStyle: true)




          ],
        ),
      ),
    );
  }
Widget builtListTile ({required String icon , required ThemeProvider themeProvider,
  required String title ,   required String textButtonTitle , required VoidCallback TextButtonOnTap
}){
    return ListTile(
        leading: SvgPicture.asset(icon,
          colorFilter: ColorFilter.mode(themeProvider.isLight()?
              AppColorLight.mainColor : AppColorDark.white, .srcIn),),

        title: Text(title,style:themeProvider.isLight()?
        AppStyleLight.med16MainText :AppStyleDark.med16White,)

        ,trailing: TextButton(onPressed: TextButtonOnTap, child: Text(textButtonTitle)));
}
}
