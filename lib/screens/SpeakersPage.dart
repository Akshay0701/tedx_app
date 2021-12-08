import 'package:flutter/material.dart';
import 'package:tedx_app/constants.dart';
import 'package:tedx_app/helper/firebase_helper.dart';
import 'package:tedx_app/models/Speaker.dart';
import 'package:tedx_app/screens/SpeakerInfoPage.dart';
import 'package:tedx_app/staticData.dart';
import 'package:tedx_app/widgets/SliverAppBar.dart';
import 'package:tedx_app/widgets/SpeakerBox.dart';

class SpeakersPage extends StatefulWidget {
  const SpeakersPage({Key? key}) : super(key: key);

  @override
  _SpeakersPageState createState() => _SpeakersPageState();
}

class _SpeakersPageState extends State<SpeakersPage> {

  FirebaseHelper _firebaseHelper = new FirebaseHelper();

  List<Speaker> speakerList = [];

  @override
  void initState() {
    super.initState();
    _firebaseHelper.fetchAllSpeaker().then((list) => {
        setState(() {
          speakerList = list; 
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
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Our Speakers",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            speakerList.length == -1 ? 
            Center(child: CircularProgressIndicator())
            : SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext cnt, int index) => GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SpeakerInfoPage(
                                    speaker: speakerList[index]))),
                        child: SpeakerBox(
                          speaker: speakerList[index],
                        ),
                      ),
                  childCount: speakerList.length),
            )
          ],
        ),
      )),
    );
  }
}
