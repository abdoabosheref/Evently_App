import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/core/class_model/event_model.dart';
import 'package:evently_app/core/class_model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseUtils {

  static CollectionReference<EventModel> getEventCollection(String uId) {
    return getUserCollection().doc(uId).collection(EventModel.collectionName)
        .withConverter<EventModel>(
      fromFirestore: (snapshot, options) =>
          EventModel.fromFireStore(snapshot.data()!),
      toFirestore: (EventModel, options) => EventModel.toFireStore(),
    );

  }

  static Future<void> addEventToFireStore(EventModel event , String uId) {
    var collectionRef = getEventCollection(uId);
    var docRef = collectionRef.doc();
    event.id = docRef.id ;
    return docRef.set(event);

  }


 static CollectionReference<MyUser> getUserCollection (){
   return FirebaseFirestore.instance.collection(MyUser.collectionName)
        .withConverter<MyUser>(
        fromFirestore: (snapshot, options) => MyUser.fromFireStore(snapshot.data()!)
        , toFirestore: (MyUser, options) => MyUser.toFireStore(),);
 }

  static Future<void> addUserToFireStore (MyUser user){
    var userCollection = getUserCollection();
    var userDoc = userCollection.doc(user.id);
    return userDoc.set(user);
  }

 static Future<MyUser?> readUserFromFireStore(String id) async {
   var querySnapShots = await getUserCollection().doc(id).get();
   return querySnapShots.data();

 }

static Future<void> updateEventToFireStore (EventModel event , String uId)async {
    return getEventCollection(uId).doc(event.id).update(event.toFireStore());
}

static Future<void> deleteEvent (EventModel event ,String uId)async {

    return getEventCollection(uId).doc(event.id).delete();
  }



}
