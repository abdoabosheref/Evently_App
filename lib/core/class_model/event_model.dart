class EventModel {

  static const String collectionName = 'Events';

  String id;
  String image;
  String title;
  String description;
  String name;
  bool isFavourite = false;
  DateTime eventDate;
  String eventTime;

  EventModel({
    this.id = '',
    required this.image,
    required this.title,
    required this.description,
    this.isFavourite = false,
    required this.name,
    required this.eventDate,
    required this.eventTime,
  });


  //Todo: json to object
  EventModel.fromFireStore(Map<String,dynamic> data):this(
    image: data['image'],
    title: data['title'],
    name: data['name'],
    description:data['description'],
    eventDate: DateTime.fromMillisecondsSinceEpoch(data['eventDate']),
    eventTime: data['eventTime'],
    id: data['id'],
    isFavourite: data['isFavourite'],

  );

  //todo : object to json
  Map<String,dynamic> toFireStore(){

    return {
      'id' : id ,
      'image' : image ,
      'title' : title ,
      'description' : description ,
      'name' : name ,
      'isFavourite' : isFavourite ,
      'eventDate' : eventDate.millisecondsSinceEpoch ,
      'eventTime' : eventTime ,
    };
  }



}





