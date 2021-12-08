import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tedx_app/constants.dart';
import 'package:tedx_app/helper/auth_methods.dart';
import 'package:tedx_app/screens/LoginPage.dart';
import 'package:tedx_app/screens/SignupPage.dart';
import 'package:tedx_app/screens/TabView.dart';

class ResetPassPage extends StatefulWidget {
  const ResetPassPage({Key? key}) : super(key: key);

  @override
  _ResetPassPageState createState() => _ResetPassPageState();
}

class _ResetPassPageState extends State<ResetPassPage> {
  // AuthMethods _authMethods = new AuthMethods();
  String _email = '';
  final auth = FirebaseAuth.instance;

  reset(_email) {
    if (_email != null) {
      auth.sendPasswordResetEmail(email: _email);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('ERROR'),
          content: Text('enter email'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('OK'),
            )
          ],
        ),
      );
    }
  }

  TextEditingController textEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('lib/assets/RAIT.png', fit: BoxFit.cover),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 9, sigmaY: 9),
              child: Container(
                color: Colors.black.withOpacity(0.5),
                alignment: Alignment.center,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 20),
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          "Enter your registered Email-id below ",
                          style: TextStyle(fontSize: 16, color: Colors.white60),
                        ),
                      ),
                      Container(
                        child: Text(
                          "to reset your Password",
                          style: TextStyle(fontSize: 16, color: Colors.white60),
                        ),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  controller: textEmailController,
                  decoration: getInputDecoration(
                      hintText: "Enter Email", icon: Icon(Icons.email)),
                  keyboardType: TextInputType.emailAddress,
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    reset(textEmailController.text);
                    await showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Successful'),
                        content: Text(
                            'A link has been sent in mail to your email-id, where you can reset your password'),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text('OK'),
                          )
                        ],
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: kRed,
                        borderRadius:
                            BorderRadius.circular(size.height * 0.08)),
                    height: size.height * 0.07,
                    width: size.width * 0.6,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: FittedBox(
                        fit: BoxFit.none,
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
