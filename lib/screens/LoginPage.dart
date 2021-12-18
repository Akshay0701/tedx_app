import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tedx_app/constants.dart';
import 'package:tedx_app/helper/auth_methods.dart';
import 'package:tedx_app/screens/ResetPass.dart';
import 'package:tedx_app/screens/SignupPage.dart';
import 'package:tedx_app/screens/TabView.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  AuthMethods _authMethods = new AuthMethods();

  TextEditingController textPasswordController=TextEditingController();
  TextEditingController textEmailController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('lib/assets/Cover_page_design.png', fit: BoxFit.fill),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
              child: Container(
                color: Colors.black.withOpacity(0.2),
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
                TextFormField(
                  controller: textEmailController,
                  decoration: getInputDecoration(
                      hintText: "Enter Email", icon: Icon(Icons.email)),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                TextFormField(
                  controller: textPasswordController,
                  obscureText: true,
                  decoration: getInputDecoration(
                      hintText: "Enter Password", icon: Icon(Icons.lock)),
                  keyboardType: TextInputType.emailAddress,
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    _authMethods.handleSignInEmail(textEmailController.text, textPasswordController.text).then((value) => {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => TabView()),
                        ),
                    });
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
                        fit: BoxFit.contain,
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  ),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'New User? ',
                            style:
                                TextStyle(color: Colors.white60, fontSize: 20)),
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                 GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => (ResetPassPage())),
                  ),
                  child: Container(child: Text("Forget password?",style: TextStyle(
                            color: Colors.white70,fontSize: 16),),),
                  
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
