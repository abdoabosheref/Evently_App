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

class EventDetails extends StatelessWidget {
  EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: PreferredSize(preferredSize:  Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            onTap: ()=> Navigator.pop(context,AppRoutes.addEventScreenRoute),
            appLocalText: AppLocalizations.of(context)!.eventDetailsText,
            showModifiedActionButtons: true,
            onTapDelete: (){},
            onTapEdit: (){
              Navigator.pushNamed(context, AppRoutes.editEventScreenRoute);
            },)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:AppSize.width* 0.04,
            vertical: AppSize.height*0.02),
        child: Column(
          spacing: AppSize.height*0.01,
          children: [
            CustomEventsImageBox( imagePathInLight: AppImage.meetingLight,
              imagePathInDark: AppImage.meetingDark,),

            Align(alignment: .centerLeft,
              child: Text('We’re going to play football',style:themeProvider.isLight()
                  ? AppStyleLight.med18MainText
                  :AppStyleDark.med18White,),
            ),
           builtContainer(
               context: context,
               child: Row(spacing: 16.0,
                 children: [
                   builtContainer(
                     padding: 10.0,
                       borderRadius: 8.0,
                       context: context,
                       child: SvgPicture.asset(AppIcon.calender,
                         colorFilter: ColorFilter.mode(
                             themeProvider.isLight()?AppColorLight.mainColor
                                 :AppColorDark.mainColor,
                             BlendMode.srcIn),),
                       height: 44.0,
                       width: 44.0),

                   Column(mainAxisAlignment: .center,crossAxisAlignment: .start,
                     children: [
                       Text('21 January',style: themeProvider.isLight()?
                         AppStyleLight.med16MainText
                           :AppStyleDark.med16White,),
                       Text('12:12 PM',style: themeProvider.isLight()?
                       AppStyleLight.med16Disable
                           :AppStyleDark.med16White,),

                     ],
                   ),

                 ],
               ),
               height: AppSize.height*0.10, width: double.infinity),

            Align(alignment: .centerLeft,
              child: Text('Description',style:themeProvider.isLight()
                  ? AppStyleLight.med18MainText
                  :AppStyleDark.med18White,),
            ),
            CustomTextFormField(hintText: "Event Description....",
              maxLines: 7,
              onChanged: (value) {},),




          ],
        ),
      ),
    );
  }
  Widget builtContainer ({ required BuildContext context,
    required Widget child, required height ,required width,
  padding = 16.0,borderRadius=16.0})
  {return Container(padding: EdgeInsets.all(padding),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: Theme.of(context).colorScheme.primaryFixed),
        color: Theme.of(context).colorScheme.primaryContainer),
    width: width,height: height,
    child: child,);
  }
}
