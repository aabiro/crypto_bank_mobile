import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/services/local_authentication_service.dart';
import 'package:flutter_app/services/service_locator.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../helpers/user_helper.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'dart:convert';
import '../providers/authentication.dart';
import 'package:provider/provider.dart';
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
            padding: const EdgeInsets.all(36.0),
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
                SizedBox(
                  height: 15.0,
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Constants.mainColor,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
                SizedBox(
                  height: 5.0,
                ),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
                    minWidth: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
}
