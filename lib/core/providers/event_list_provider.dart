import 'package:evently_app/core/class_model/lists.dart';
import 'package:flutter/material.dart';

import '../../fire_base_utils.dart';
import '../../l10n/app_localizations.dart';
import '../class_model/event_model.dart';

class EventListProvider extends ChangeNotifier {
  int selectedIndex = 0;
  List<EventModel> eventList = [];
  List<String> eventNameList = [];
  List<EventModel> filterEventsList = [];
  List<EventModel> favouriteList = [];

  List<String> categoryText(BuildContext context) {
    return eventNameList = [
      AppLocalizations.of(context)!.categoryAll,
      AppLocalizations.of(context)!.categorySport,
      AppLocalizations.of(context)!.categoryBirthday,
      AppLocalizations.of(context)!.categoryBookClub,
      AppLocalizations.of(context)!.categoryExhibition,
      AppLocalizations.of(context)!.categoryMeeting,
    ];
  }

  void changeSelectedIndex(int index,String uId) {
    selectedIndex = index;
    selectedIndex == 0
        ? addAllEventsFromFireStore(uId)
        : getFilterListFromFireStore(uId);
  }

  void addAllEventsFromFireStore(String uId) async {
    // read collection then get the documents throw .get() method
    var querySnapShot = await FireBaseUtils.getEventCollection(uId).get();
    //turn List<event> => List<QuerySnapshot<EventModel>> throw .map() method
    // that returns the documents data
    eventList = querySnapShot.docs.map((doc) {
      return doc.data();
    }).toList();
    filterEventsList = eventList;
    notifyListeners();
    // call the function inside   init state
  }

  void getFilterEvents(String uId) async {
    var querySnapShots = await FireBaseUtils.getEventCollection(uId).get();
    eventList = querySnapShots.docs.map((doc) {
      return doc.data();
    }).toList();
    filterEventsList = eventList.where((event) {
      return event.name == eventNameList[selectedIndex];
    }).toList();

    notifyListeners();
  }

  void getFilterListFromFireStore(String uId) async {
    var querySnapShots = await FireBaseUtils.getEventCollection(uId)
        .orderBy('eventDate')
        .where('name', isEqualTo: eventNameList[selectedIndex])
        .get();
    filterEventsList = querySnapShots.docs.map((doc) {
      return doc.data();
    }).toList();
    notifyListeners();
  }

  void updateIsFavourite(EventModel event,String uId) {
    FireBaseUtils.getEventCollection(uId)
        .doc(event.id)
        .update({'isFavourite': !event.isFavourite})
        .then((value) {
          selectedIndex == 0
              ? addAllEventsFromFireStore(uId)
              : getFilterListFromFireStore(uId);
          getAllFavouriteEvents(uId);
        });
    // timeout( Duration(milliseconds: 500));
    // print('event updated successfully');
    notifyListeners();
  }

  void getAllFavouriteEvents(String uId) async {
    var querySnapshot = await FireBaseUtils.getEventCollection(uId)
        .orderBy('eventDate')
        .where('isFavourite', isEqualTo: true)
        .get();

    favouriteList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    notifyListeners();
  }
}
