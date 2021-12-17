import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tedx_app/constants.dart';
import 'package:tedx_app/helper/firebase_helper.dart';
import 'package:tedx_app/models/Event.dart';
import 'package:tedx_app/screens/EventInfoPage.dart';
import 'package:tedx_app/screens/LoginPage.dart';
import 'package:tedx_app/staticData.dart';
import 'package:tedx_app/widgets/EventBox.dart';
import 'package:tedx_app/widgets/PageViewTile.dart';
import 'package:tedx_app/widgets/SliverAppBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  FirebaseHelper _firebaseHelper = new FirebaseHelper();

  List<Event> eventlist = [];
  double selectedindex = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signOut() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => (LoginPage())),
    );
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Logout'),
        content: Text(
            'You have been successfully logged out, now you will be redirected to Login page'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: Text('OK'),
          )
        ],
      ),
    );
    return await _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    _firebaseHelper.fetchUpcomingEvent().then((list) => {
        setState(() {
          eventlist = list; 
        })
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: kGrey,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                "TEDxDYPatilUniversity",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w900),
              ),
              floating: true,
              pinned: false,
              backgroundColor: kGrey.withOpacity(0.5),
              actions: [ IconButton(
              icon: const Icon(Icons.logout_rounded),
              onPressed: () { signOut(); },
            ),],
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.grey.shade800,
                height: MediaQuery.of(context).size.height / 3,
                child: Center(
                  child: PageView(
                    controller: PageController(
                      viewportFraction: 1,
                      initialPage: 0,
                    ),
                    onPageChanged: (int page) {
                        setState(() {
                            selectedindex = page + 0.0;
                        });
                    },
                    children: [
                      PageViewTile(
                        networkImage: NetworkImage(
                            'https://github.com/Swapnilsochill/TEDXDYPatilUniversity/blob/main/Images/Untitledesign.png?raw=true'),
                      ),
                      PageViewTile(
                        networkImage: NetworkImage(
                            'https://github.com/Swapnilsochill/TEDXDYPatilUniversity/blob/main/Images/speakerhero.jpg?raw=true'),
                      ),
                      PageViewTile(
                        networkImage: NetworkImage(
                            'https://github.com/Swapnilsochill/TEDXDYPatilUniversity/blob/main/Images/Tedhero.jpg?raw=true'),
                      )
                    ],
                  ),
                ),
              ),
            ),
             SliverToBoxAdapter(
              child: new DotsIndicator(
                dotsCount: 3,
                decorator: DotsDecorator(
                  activeColor: Colors.red,
                ),
                position: selectedindex
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Upcoming Events 2022",
                  style: kHeadingStyle,
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
                              isEventDone: false,
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
      ),
    );
  }

  Widget _indicator(bool isActive) {
      return Container(
        height: 10,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          height: isActive
              ? 10:8.0,
          width: isActive
              ? 12:8.0,
          decoration: BoxDecoration(
            boxShadow: [
              isActive
                  ? BoxShadow(
                color: Color(0XFF2FB7B2).withOpacity(0.72),
                blurRadius: 4.0,
                spreadRadius: 1.0,
                offset: Offset(
                  0.0,
                  0.0,
                ),
              )
                  : BoxShadow(
                color: Colors.transparent,
              )
            ],
            shape: BoxShape.circle,
            color: isActive ? Color(0XFF6BC4C9) : Color(0XFFEAEAEA),
          ),
        ),
      );
    }

    List<Widget> _buildPageIndicator() {
      List<Widget> list = [];
      for (int i = 0; i < 3; i++) {
        list.add(i == selectedindex ? _indicator(true) : _indicator(false));
      }
      return list;
    }
}
