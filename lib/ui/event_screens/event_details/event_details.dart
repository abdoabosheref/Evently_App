import 'package:evently_app/core/custom_widget/Custom_alert_dialog.dart';
import 'package:evently_app/core/custom_widget/custom_app_bar.dart';
import 'package:evently_app/core/custom_widget/custom_snack_bar.dart';
import 'package:evently_app/core/custom_widget/custom_text_form_field.dart';
import 'package:evently_app/core/providers/event_list_provider.dart';
import 'package:evently_app/util/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/class_model/event_model.dart';
import '../../../core/custom_widget/custom_events_image_box.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../core/providers/user_provider.dart';
import '../../../fire_base_utils.dart';
import '../../../l10n/app_localizations.dart';
import '../../../util/app_color_light_dark.dart';
import '../../../util/app_icon.dart';
import '../../../util/app_routes.dart';
import '../../../util/app_size.dart';
import '../../../util/app_style_light_dark.dart';

class EventDetails extends StatefulWidget {
  EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
final EventModel event = ModalRoute.of(context)?.settings.arguments as EventModel;


    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: PreferredSize(preferredSize:  Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            onTap: ()=> Navigator.pop(context),
            appLocalText: Text(AppLocalizations.of(context)!.eventDetailsText),
            showModifiedActionButtons: true,
            onTapDelete: (){
              CustomAlertDialog.showAlert(context: context,
                  title: 'Delete Event',
                  actions: [
                    IconButton(onPressed: () async {
                      try {
                        var userProvider = Provider.of<UserProvider>(context, listen: false);
                        var eventListProvider = Provider.of<EventListProvider>(context, listen: false);
                        await FireBaseUtils.deleteEvent(event, userProvider.currentUser!.id);
                        eventListProvider.addAllEventsFromFireStore(userProvider.currentUser!.id);
                        Navigator.pop(context);
                        CustomSnackBar.snackBarAlert(context, 'Event Deleted Successfully');
                        Navigator.pushReplacementNamed(context, AppRoutes.homeScreenRoute);
                      } catch (e) {
                        print("Delete Error: $e");
                        CustomSnackBar.snackBarAlert(context, 'Failed to delete event');
                      }
                    }, icon: Text("Delete"),
                    ),
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Text("Back"),
                    )
                  ]);
            },
            onTapEdit: (){
              Navigator.pushNamed(context, AppRoutes.editEventScreenRoute,
              arguments: event);
            },)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:AppSize.width* 0.04,
            vertical: AppSize.height*0.02),
        child: SingleChildScrollView(
          child: Column(
            spacing: AppSize.height*0.01,
            children: [
              CustomEventsImageBox(image: event.image ),

              Align(alignment: .centerLeft,
                child: Text(event.title,style:themeProvider.isLight()
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
                         Text(DateFormat('d MMMM yyyy').format(event.eventDate),style: themeProvider.isLight()?
                           AppStyleLight.med16MainText
                             :AppStyleDark.med16White,),
                         Text(event.eventTime,style: themeProvider.isLight()?
                         AppStyleLight.med16Disable
                             :AppStyleDark.med16White,),

                       ],
                     ),

                   ],
                 ),
                 height: AppSize.height*0.10, width: double.infinity),

              Align(alignment: .centerLeft,
                child: Text(AppLocalizations.of(context)!.descriptionText,
                  style:themeProvider.isLight()
                    ? AppStyleLight.med18MainText
                    :AppStyleDark.med18White,),
              ),
              CustomTextFormField(hintText:event.description,
                readOnly: true,
                maxLines: 7,
                onChanged: (value) {},),




            ],
          ),
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
