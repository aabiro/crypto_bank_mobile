import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/services/local_authentication_service.dart';
import 'package:flutter_app/services/service_locator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'dart:convert';

import 'package:path/path.dart';

// Create a Form widget.
class LoginScreen extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final myUsernameController = TextEditingController();
  final myPasswordController = TextEditingController();


  Widget buildMaterialButton(String text, Function goTo, Color _color, double widthDivisor, double _fontSize, BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: _color,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width/widthDivisor,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: goTo,
        child: Text(text, 
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: _fontSize,
            fontWeight: FontWeight.w700,
            color: Colors.white
          ),
        ),
      ),
    );
  }

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
    final LocalAuthenticationService _localAuth = locator<LocalAuthenticationService>();
    final usernameField = buildInputField(myUsernameController, "Username");
    final passwordField = buildInputField(myPasswordController, "Password");
    String username = myUsernameController.text;
    String password = myPasswordController.text;

    final url = "http://10.0.2.2:8888/auth/token";
    // final body = "{\"username\":\"$username\", \"password\": \"$password\", \"grant_type\": \"password\"}";
    final body = "username=$username&password=$password&grant_type=password";
    Future<void> _login() async {
      // final storage = new FlutterSecureStorage();
      // String accessToken = await storage.read(key: "access_token");

      final clientID = "com.example.flutter_app";
      final mysecret = "mysecret";
      final clientCredentials =
          Base64Encoder().convert("$clientID:$mysecret".codeUnits);
      try {
        await http
            .post(url,
                headers: {
                  "Content-Type": "application/x-www-form-urlencoded",
                  "Authorization": "Basic $clientCredentials"
                },
                body: body)
            .then((http.Response response) {
          final int statusCode = response.statusCode;

          if (statusCode < 200 || statusCode >= 400 || json == null) {
            throw new Exception("Error while fetching data");
          } else {
            print(json.decode(response.body));
            Navigator.pushReplacementNamed(context, '/home');
          }
        });
      } catch (e) {
        print(e);
      }
    }

    final loginButon = buildMaterialButton("Login", _login, Constants.mainColor, 1, 18, context);
    final localAuthButon = buildMaterialButton("Use Face/Touch ID", _localAuth.authenticate, Constants.accentColor, 2, 12, context);

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
                    "assets/gnglogo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 15.0),
                usernameField,
                SizedBox(height: 15.0),
                passwordField,
                SizedBox(
                  height: 15.0,
                ),
                loginButon,
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
                localAuthButon
              ],
            ),
          ),
        ),
      ),
    );
  }
}
