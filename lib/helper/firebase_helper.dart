
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tedx_app/models/Event.dart' as event;
import 'package:tedx_app/models/Speaker.dart';

class FirebaseHelper {

  // static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // static final CollectionReference _eventCollection = _firestore.collection("Events");
  // static final CollectionReference _speakerCollection = _firestore.collection("Speakers");

  // Firebase Database, will use to get reference.
  static final FirebaseDatabase _database = FirebaseDatabase.instance;

  static final DatabaseReference _eventCollection = _database.reference().child("Events");
  static final DatabaseReference _speakerCollection = _database.reference().child("Speakers");

  // fetch previous events list from food reference
  Future<List<event.Event>> fetchAllEvent() async {
    List<event.Event> eventList = <event.Event>[];
    await _eventCollection.once().then((DataSnapshot snap) {
        var keys = snap.value.keys;
        var data = snap.value;
        eventList.clear();
        for(var individualKey in keys){
          event.Event eventData = new event.Event(
            eventInfo: data[individualKey]["eventInfo"] ?? "", 
            formLink: data[individualKey]["formLink"] ?? "", 
            bannerLink: data[individualKey]["bannerLink"] ?? "", 
            eventName: data[individualKey]["eventName"] ?? "",
            isOpen: data[individualKey]["isOpen"] ?? false,
            speaker: new Speaker(
              imageUrl: data[individualKey]["speaker"]["imageUrl"] ?? "",
              info: data[individualKey]["speaker"]["info"] ?? "",
              profession: data[individualKey]["speaker"]["profession"] ?? "",
              name: data[individualKey]["speaker"]["name"] ?? "",
              )
          );
          // add all closed events in list
          if (!eventData.isOpen)
            eventList.add(eventData);
        }
      });
      return eventList;
  }

  // fetch previous events list from food reference
  Future<List<event.Event>> fetchUpcomingEvent() async {
    List<event.Event> eventList = <event.Event>[];
    await _eventCollection.once().then((DataSnapshot snap) {
        var keys = snap.value.keys;
        var data = snap.value;
        eventList.clear();
        for(var individualKey in keys){
          event.Event eventData = new event.Event(
            eventInfo: data[individualKey]["eventInfo"] ?? "", 
            formLink: data[individualKey]["formLink"] ?? "", 
            bannerLink: data[individualKey]["bannerLink"] ?? "", 
            eventName: data[individualKey]["eventName"] ?? "",
            isOpen: data[individualKey]["isOpen"] ?? true,
            speaker: new Speaker(
              imageUrl: data[individualKey]["speaker"]["imageUrl"] ?? "",
              info: data[individualKey]["speaker"]["info"] ?? "",
              profession: data[individualKey]["speaker"]["profession"] ?? "",
              name: data[individualKey]["speaker"]["name"] ?? "",
              )
          );
          // add all open events in list
          if (eventData.isOpen)
            eventList.add(eventData);
        }
      });
      return eventList;
  }

   // fetch all speaker list from food reference
  Future<List<Speaker>> fetchAllSpeaker() async {
    List<Speaker> speakerList = <Speaker>[];
    await _speakerCollection.once().then((DataSnapshot snap) {
        var keys = snap.value.keys;
        var data = snap.value;
        speakerList.clear();
        for(var individualKey in keys){
          Speaker speaker = new Speaker(
              imageUrl: data[individualKey]["imageUrl"],
              info: data[individualKey]["info"],
              profession: data[individualKey]["profession"],
              name: data[individualKey]["name"],
              );
          speakerList.add(speaker);
        }
      });
      return speakerList;
  }

}