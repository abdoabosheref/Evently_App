
import 'package:evently_app/core/custom_widget/custom_app_bar.dart';
import 'package:evently_app/core/custom_widget/custom_elevated_button.dart';
import 'package:evently_app/core/custom_widget/custom_snack_bar.dart';
import 'package:evently_app/core/custom_widget/custom_text_form_field.dart';
import 'package:evently_app/core/providers/event_list_provider.dart';
import 'package:evently_app/core/providers/user_provider.dart';
import 'package:evently_app/fire_base_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/class_model/event_model.dart';
import '../../../core/class_model/lists.dart';
import '../../../core/custom_widget/custom_events_image_box.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../util/app_color_light_dark.dart';
import '../../../util/app_icon.dart';
import '../../../util/app_routes.dart';
import '../../../util/app_size.dart';
import '../../../util/app_style_light_dark.dart';

class EditEvent extends StatefulWidget {
  EditEvent({super.key});

  @override
  State<EditEvent> createState() => _AddEventState();
}

class _AddEventState extends State<EditEvent> {
 bool addEventScreen = false ;
 late EventListProvider eventListProvider ;
  int selectedIndex = 0;
  bool isFirstTime = true;
  EventModel ? event;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String formattedTime = '';
 String formateDate = '';


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirstTime) {
      event = ModalRoute.of(context)!.settings.arguments as EventModel;
      titleController.text = event!.title;
      descriptionController.text = event!.description;
      selectedDate = event!.eventDate;
      formattedTime = event!.eventTime;
      selectedIndex = ListData.addEventCategoryText(context).indexOf(event!.name);
      if (selectedIndex == -1) selectedIndex = 0;
      isFirstTime = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    eventListProvider =Provider.of<EventListProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);

    if (event == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Form(
      key: formKey,
      child: Scaffold(
        appBar: PreferredSize(preferredSize:  Size.fromHeight(kToolbarHeight),
            child: CustomAppBar(
              onTap: ()=> Navigator.pop(context,AppRoutes.eventDetailsScreenRoute),
              appLocalText: Text(AppLocalizations.of(context)!.editEventText),
              showModifiedActionButtons: false,
              onTapDelete: (){},
              onTapEdit: (){},)),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal:AppSize.width* 0.04,
              vertical: AppSize.height*0.02),
          child: SingleChildScrollView(
            child: Column(
              spacing: AppSize.height*0.01,
              children: [
                CustomEventsImageBox(image: themeProvider.isLight()
                    ? ListData.eventImageLightList[selectedIndex]
                    : ListData.eventImageDarkList[selectedIndex]  ,),
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
                              });
                            },
                            child: categoryTabs(
                              itemBuilderIndex: index,
                              themeProvider: themeProvider.isLight(),
                              categoryList: ListData.addEventCategoryText(context)[index],
                              iconsList: ListData.addEventCategoryIcons[index] ,
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10, width: 10),
                          itemCount:ListData.addEventCategoryText(context).length,
                        ),
                      ),
                    ),
                  ],
                ),

                Align(alignment: .centerLeft,
                  child: Text(AppLocalizations.of(context)!.titleText,style:themeProvider.isLight()
                      ? AppStyleLight.med16MainText
                      :AppStyleDark.med16White,),
                ),
                CustomTextFormField(controller: titleController,
                  hintText:AppLocalizations.of(context)!.titleHint,),
                Align(alignment: .centerLeft,
                  child: Text(AppLocalizations.of(context)!.descriptionText,style:themeProvider.isLight()
                      ? AppStyleLight.med16MainText
                      :AppStyleDark.med16White,),
                ),
                CustomTextFormField(controller:descriptionController,
                  maxLines: 7, hintText:AppLocalizations.of(context)!.descriptionHint,),
                builtListTile(icon: AppIcon.calender,
                    themeProvider: themeProvider,
                    title: AppLocalizations.of(context)!.eventDateText,
                    textButtonTitle:DateFormat('d MMMM yyyy').format(selectedDate!),
                    TextButtonOnTap: () {
                      onChooseDate();
                    }),
                builtListTile(icon: AppIcon.clock,
                    themeProvider: themeProvider,
                    title:AppLocalizations.of(context)!.eventTimeText,
                    textButtonTitle:formattedTime,
                    TextButtonOnTap: () {
                      onChooseTime();
                    }),
                CustomElevatedButton(
                    appLocalText:AppLocalizations.of(context)!.updateEventButton,
                    onTap: ()async {

                     if(formKey.currentState?.validate()==true){
                       event!.title = titleController.text;
                       event!.description = descriptionController.text;
                       event!.eventDate = selectedDate!;
                       event!.eventTime = formattedTime!;
                       event!.name = ListData.addEventCategoryText(context)[selectedIndex];
                       event!.image = event!.image = themeProvider.isLight()
                           ? ListData.eventImageLightList[selectedIndex]
                           : ListData.eventImageDarkList[selectedIndex];
                       UserProvider userProvider = Provider.of<UserProvider>(context,listen: false);

                       try {

                         await FireBaseUtils.updateEventToFireStore(event!, userProvider.currentUser!.id);
                         eventListProvider.addAllEventsFromFireStore(userProvider.currentUser!.id);
                         Navigator.pop(context);
                           CustomSnackBar.snackBarAlert(context, 'Event Updated Successfully');
                       } catch (e) {
                         print("Update Error: $e");
                       }
                     }

                     },
                    switchButtonStyle: true)




              ],
            ),
          ),
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

 void onChooseDate() async{
   var chooseDate =await showDatePicker(context: context,
       initialDate: DateTime.now(),
       firstDate: DateTime.now(),
       lastDate: DateTime.now().add(Duration(days: 365)));
   selectedDate = chooseDate ;
   if(selectedDate != null){
     formateDate = DateFormat('MMM d,yyyy').format(selectedDate!) ;
     setState(() {});
   }
 }

 void onChooseTime() async{
   var chooseTime = await showTimePicker(context: context,
       initialTime: TimeOfDay.now());
   selectedTime = chooseTime  ;
   if(selectedTime != null){
     formattedTime = selectedTime!.format(context) ;
   }
   setState(() {

   });

 }
}



