import 'package:evently_app/core/class_model/event_model.dart';
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
import '../../../core/class_model/lists.dart';
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
  bool  addEventScreen = true ;
  int selectedIndex = 0 ;
  var selectedEventImage= '' ;
  var selectedEventName = '';
  var title = '';
  var description = '';
  DateTime ? selectedDate ;
  String  formateDate = '' ;
  TimeOfDay ? selectedTime ;
  String  formateTime = '' ;
  late EventListProvider eventListProvider ;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    eventListProvider = Provider.of<EventListProvider>(context);
var themeProvider = Provider.of<ThemeProvider>(context);
selectedEventName = ListData.addEventCategoryText(context)[selectedIndex] ;
selectedEventImage = themeProvider.isLight()
    ? ListData.eventImageLightList[selectedIndex]
    :ListData.eventImageDarkList[selectedIndex] ;

    return Scaffold(
      appBar: PreferredSize(preferredSize:  Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
              onTap: ()=> Navigator.pop(context,AppRoutes.homeScreenRoute),
              appLocalText: Text(AppLocalizations.of(context)!.addEventText),
              showModifiedActionButtons: false,
          onTapDelete: (){},
          onTapEdit: (){},)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:AppSize.width* 0.04,
        vertical: AppSize.height*0.02),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              spacing: AppSize.height*0.01,
              children: [
                CustomEventsImageBox(image: selectedEventImage),
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
                          CustomEventsImageBox(image: themeProvider.isLight()
                              ? ListData.eventImageLightList[selectedIndex]
                              : ListData.eventImageDarkList[selectedIndex]  ,);
                          setState(() {
                            //Todo : tabs Filter List view
                          });
                        },
                        child: categoryTabs(
                          itemBuilderIndex: index,
                          themeProvider: themeProvider.isLight(),
                          categoryList:addEventScreen?  ListData.addEventCategoryText(context)[index] : eventListProvider.categoryText(context)[index],
                          iconsList: addEventScreen?  ListData.addEventCategoryIcons[index] : ListData.categoryIcons[index] ,
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10, width: 10),
                      itemCount:addEventScreen?  ListData.addEventCategoryText(context).length : eventListProvider.categoryText(context).length,
                    ),
                  ),
                ),
              ],
            ),
                Align(alignment: .centerLeft,
                  child: Text('Title',style:themeProvider.isLight()
                      ? AppStyleLight.med16MainText
                      :AppStyleDark.med16White,),
                ),
                CustomTextFormField(hintText: "Event Title",
                  validator: (value) {
                    if(value!.trim().isEmpty) {
                      return 'Enter title';
                    }
                    return null ;
                  },
            
                  onChanged: (value) {
                  title = value ;
                  },),
                Align(alignment: .centerLeft,
                  child: Text('Description',style:themeProvider.isLight()
                      ? AppStyleLight.med16MainText
                      :AppStyleDark.med16White,),
                ),
                CustomTextFormField(hintText: "Event Description....",
                  validator: (value) {
                    if(value!.trim().isEmpty) {
                      return 'Enter description';
                    }
                    return null ;
                  },
                  maxLines: 7,
                  onChanged: (value) {
                  description = value ;
                  },),
                builtListTile(icon: AppIcon.calender,
                    themeProvider: themeProvider,
                    title: AppLocalizations.of(context)!.eventDateText,
                    textButtonTitle: selectedDate == null
                        ? AppLocalizations.of(context)!.chooseDate
                        :formateDate,
                    TextButtonOnTap: () {
                  onChooseDate();
                    }),
                builtListTile(icon: AppIcon.clock,
                    themeProvider: themeProvider,
                    title:AppLocalizations.of(context)!.eventTimeText,
                    textButtonTitle:selectedTime==null
                        ? AppLocalizations.of(context)!.chooseTime
                    : formateTime,
                    TextButtonOnTap: () {
                  onChooseTime();
                    }),
                CustomElevatedButton(
                    appLocalText:AppLocalizations.of(context)!.addEventText,
                    onTap: () {
                     addEvent();
                     setState(() {
            
                     });
            
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
     formateTime = selectedTime!.format(context) ;
   }
   setState(() {

   });

  }

  void addEvent() {
    if(formKey.currentState!.validate() == true){
      if(selectedDate == null || selectedTime == null){


      }
      //Todo: Add Event to fireStore
      EventModel event = EventModel(
          image: selectedEventImage,
          title: title,
          description: description,
          name: selectedEventName,
          eventDate: selectedDate!,
          eventTime: formateTime );
      var userProvider=Provider.of<UserProvider>(context,listen: false);
      FireBaseUtils.addEventToFireStore(event,userProvider.currentUser!.id )
          .then((value) {
        print('event added');
        eventListProvider.addAllEventsFromFireStore(userProvider.currentUser!.id);
        Navigator.pop(context);

        //Todo : alert & toast & snack
        CustomSnackBar.snackBarAlert(context, 'Event Added');

      },);


    }


  }

}
