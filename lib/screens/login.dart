import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  static final clientID = "com.example.flutter_app"; 
  static final mysecret = "mysecret";
  final clientCredentials = Base64Encoder().convert("$clientID:$mysecret".codeUnits);
  final url = "http://10.0.2.2:8888/login";  //create this

  final myUsernameController = TextEditingController();
  final myPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final emailField = TextFormField(
      validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
      obscureText: false,
      controller: myUsernameController,
      // style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextFormField(
      validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
      obscureText: true,
      controller: myPasswordController,
      // style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
              
    );

    final email = myUsernameController.text;
    final password = myPasswordController.text;

    final body = "{\"username\":\"$email\", \"password\": \"$password\"}";
    Future<void> _login() async {
      try {
        await http.post(
          url,
          headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic $clientCredentials"
          },
          body: body
        ).then((http.Response response) {
          final int statusCode = response.statusCode;
      
          if (statusCode < 200 || statusCode > 400 || json == null) {
            throw new Exception("Error while fetching data");
          }
          return json.decode(response.body);
        });
      } catch (e) {
        print(e);
      }
    }

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_loginFormKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                   _login();
                }
              },
        child: Text("Login",
            textAlign: TextAlign.center),
            // ,
            // style: style.copyWith(
            //     color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

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
                  height: 100.0,
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButon,
                SizedBox(
                  height: 15.0,
                ),
                Text("Not registered? Register now"),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text("Register",
                      textAlign: TextAlign.center
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}