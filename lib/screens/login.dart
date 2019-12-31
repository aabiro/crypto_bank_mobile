import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/services/local_authentication_service.dart';
import 'package:flutter_app/services/service_locator.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../helpers/user_helper.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'dart:convert';
import '../providers/authentication.dart';
import 'package:provider/provider.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import 'package:path/path.dart';

// Create a Form widget.
class LoginScreen extends StatefulWidget {
  static final routeName = '/login';
  
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<LoginScreen> {
  // final _loginFormKey = GlobalKey<FormState>();
  final myEmailController = TextEditingController();
  final myPasswordController = TextEditingController();

  // bool isLoggedIn = false;

  // void onLoginStatusChanged(bool isLoggedIn) {
  //   setState(() {
  //     this.isLoggedIn = isLoggedIn;
  //   });
  // }

  Widget buildInputField(TextEditingController controller, String hintText) {
    return TextFormField(
      obscureText: false,
      controller: controller,
      decoration: InputDecoration(
        labelText: hintText,
        hintStyle: TextStyle(
          color: Color(0xff2196F3),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final LocalAuthenticationService _localAuth = locator<LocalAuthenticationService>();
    final emailField = buildInputField(myEmailController, "Email");
    final passwordField = buildInputField(myPasswordController, "Password");
    String email = myEmailController.text;
    String password = myPasswordController.text;

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 150.0,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/gnglogoblue.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 15.0),
                emailField,
                SizedBox(height: 15.0),
                passwordField,
                Padding(
                  padding: EdgeInsets.only(top: 30),
                                  child: SizedBox(
                    height: 50.0,
                    child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Constants.mainColor,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width/1.6,
                      padding: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                      onPressed: () {
                        Provider.of<Authentication>(context).login(email, password, context);
                      },
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  ),
                ),
                
                
                 Padding(
                   padding: EdgeInsets.all(10),
                                    child: SizedBox(
                    height: 35.0,
                    child: SignInButton(
                    Buttons.Facebook,
                    mini: false,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),),
                    onPressed: () {
                      Provider.of<Authentication>(context).initiateFacebookLogin(context);
                    },
                ),
                ),
                 ),
                

                // Material(
                //   elevation: 5.0,
                //   borderRadius: BorderRadius.circular(30.0),
                //   color: Constants.accentColor,
                //   child: MaterialButton(
                //     minWidth: MediaQuery.of(context).size.width,
                //     padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                //     onPressed: () {
                //       initiateFacebookLogin(context);
                //     },
                //     child: Text(
                //       "Login with Facebook",
                //       textAlign: TextAlign.center,
                //       style: TextStyle(
                //           fontSize: 18,
                //           fontWeight: FontWeight.w700,
                //           color: Colors.white),
                //     ),
                //   ),
                // ),

                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text("Or Register", textAlign: TextAlign.center),
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Constants.accentColor,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width / 1.6,
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    onPressed: _localAuth.authenticate,
                    child: Text(
                      "Use Face/Touch ID",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void initiateFacebookLogin(BuildContext context) async {
  //   var facebookLogin = FacebookLogin();
  //   var facebookLoginResult =
  //   //  await facebookLogin.logInWithReadPermissions(['email']);
  //    await facebookLogin.logIn(['email']);
  //    switch (facebookLoginResult.status) {
  //     case FacebookLoginStatus.error:
  //       print("Error");
  //       onLoginStatusChanged(false);
  //       break;
  //     case FacebookLoginStatus.cancelledByUser:
  //       print("CancelledByUser");
  //       onLoginStatusChanged(false);
  //       break;
  //     case FacebookLoginStatus.loggedIn:
  //       print("LoggedIn");
  //       onLoginStatusChanged(true);
  //       Navigator.pushReplacementNamed(context, '/home');
  //       break;
  //   }
  // }
}
