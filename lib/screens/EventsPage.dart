import 'package:flutter/material.dart';
import 'package:tedx_app/constants.dart';
import 'package:tedx_app/helper/firebase_helper.dart';
import 'package:tedx_app/models/Event.dart';
import 'package:tedx_app/screens/EventInfoPage.dart';
import 'package:tedx_app/staticData.dart';
import 'package:tedx_app/widgets/EventBox.dart';
import 'package:tedx_app/widgets/SliverAppBar.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {

  FirebaseHelper _firebaseHelper = new FirebaseHelper();

  List<Event> eventlist = [];

  @override
  void initState() {
    super.initState();
    _firebaseHelper.fetchAllEvent().then((list) => {
        setState(() {
          eventlist = list; 
          print(list);
        })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
          child: Container(
        color: kGrey,
        child: CustomScrollView(
          slivers: [
            SAppBar(title: 'TEDxDYPatilUniversity'),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Our Previous Events 2018-2019",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            eventlist.length == -1 ? 
            Center(child: CircularProgressIndicator())
            : SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext cnt, int index) => GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventsInfoPage(
                              event: eventlist[index],
                              isEventDone: true,
                            ),
                          ),
                        ),
                        child: EventBox(
                          event: eventlist[index],
                        ),
                      ),
                  childCount: eventlist.length),
            ),
          ],
        ),
      )),
    );
  }
}
