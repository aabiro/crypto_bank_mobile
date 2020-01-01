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

import 'package:path/path.dart';

// Create a Form widget.
class RegisterScreen extends StatefulWidget {
  
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}


class MyCustomFormState extends State<RegisterScreen> {
  final myEmailController = TextEditingController();
  final myPasswordController = TextEditingController();

  Widget buildInputField(TextEditingController controller, String hintText) {
    return TextFormField(
      // validator: (value) {
      //         if (value.isEmpty) {
      //           return 'Please enter some text';
      //         }
      //         return null;
      //       },
      obscureText: false,
      controller: controller,
      decoration: InputDecoration(
        // hintText: hintText,
        labelText: hintText,
        hintStyle: TextStyle(
          color: Color(0xff2196F3),
          // fontStyle: FontStyle.italic,
        ),
      ),
      // contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      // hintText: hintText,
      // border:
      //     OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final emailField = buildInputField(myEmailController, "Email");
    final passwordField = buildInputField(myPasswordController, "Password");
    String email = myEmailController.text;
    String password = myPasswordController.text;

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          // color: Color(0xff2196F3),
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
                      Provider.of<Authentication>(context, listen: false).register(email, password, context);
                      // UserHelper.Email(body, context);
                    },
                    child: Text(
                      "Register",
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
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text("Or Login", 
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontFamily: 'OpenSans',
                  ),
                  textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}