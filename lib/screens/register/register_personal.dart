import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
// import 'lib/models/user.dart';
import 'dart:convert';

// Create a Form widget.
class UserInfoScreen extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<UserInfoScreen> {
  final _personalInfoFormKey = GlobalKey<FormState>();
  static final String userId = 2.toString();
  static final userToken = '';
  final url = "http://10.0.2.2:8888/users/$userId";  //update this user

  final myFirstNameController = TextEditingController();
  final myLastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final firstNameField = TextFormField(
      validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
      obscureText: false,
      controller: myFirstNameController,
      // style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "First Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final lastNameField = TextFormField(
      validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
      obscureText: true,
      controller: myLastNameController,
      // style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Last Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
              
    );

    final birthdateField = TextFormField(
      validator: (value) {
              if (value.isEmpty) {
                return 'Please enter birthdate';
              }
              return null;
            },
      obscureText: true,
      // style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Birthdate",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
              
    );

    final firstName = myFirstNameController.text;
    final lastName = myLastNameController.text;
    final birthDate = '1989-09-23';
    final body = "{\"firstName\":\"$firstName\", \"lastName\": \"$lastName\, \"birthdate\": \"$birthDate\"}";

    Future<void> _updateUser() async {
      try {
        await http.post(
          url,
          headers: {
          "Content-Type": "application/json",
          // "Authorization": "Basic $clientCredentials"
          },
          body: body
        ).then((http.Response response) {
          final int statusCode = response.statusCode;
      
          if (statusCode < 200 || statusCode > 400 || json == null) {
            throw new Exception("Error while fetching data");
          }
          return json.decode(response.body);
          //go to next step
        });
      } catch (e) {
        print(e);
      }
    }

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
                firstNameField,
                SizedBox(height: 25.0),
                lastNameField,
                SizedBox(
                  height: 25.0,
                ),
                birthdateField,
                SizedBox(
                  height: 25.0
                ),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {
                    if(true){  //maybe a try catch instead
                      _updateUser();
                      Navigator.pushNamed(context, '/register');
                    } else {
                      return null;
                    }                 
                  },
                  child: Text("Continue",
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