import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../models/user.dart';
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
  // final _personalInfoFormKey = GlobalKey<FormState>();

  final myFirstNameController = TextEditingController();
  final myLastNameController = TextEditingController();
  final myCountryController = TextEditingController();

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
      controller: myLastNameController,
      // style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Last Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
              
    );

    final countryField = TextFormField(
      validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
      controller: myCountryController,
      // style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Country",
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
    final country = myCountryController.text;
    // final body = "{\"firstname\":\"Aaryn\", \"lastname\": \"Biro\", \"birthdate\": \"1989-09-23\"}";
    final body = "{\"firstname\":\"Aaryn\", \"lastname\": \"Biro\", \"country\":\"Canada\"}";
    // final body = "{\"firstname\":\"$firstName\", \"lastname\": \"$lastName\", \"birthdate\": \"$birthDte\"}";

    Future<void> _updateUser() async {
      final storage = new FlutterSecureStorage();
      String accessToken = await storage.read(key: "access_token");
      String userId = await storage.read(key: "id");
      final url = "http://10.0.2.2:8888/users/$userId";  //update this user
      try {
        await http.put(
          url,
          headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
          },
          body: body
        ).then((http.Response response) {
          final int statusCode = response.statusCode;
      
          if (statusCode < 200 || statusCode > 400 || json == null) {
            throw new Exception("Error while fetching data");
          }
          Navigator.pushNamed(context, '/home');
          return json.decode(response.body);
          //Update User , go to next step
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
                  height: 50.0,
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 30.0),
                firstNameField,
                SizedBox(height: 15.0),
                lastNameField,
                SizedBox(height: 15.0),
                countryField,
                SizedBox(
                  height: 15.0
                ),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: _updateUser,
                  child: Text("Continue",
                      textAlign: TextAlign.center
                  ),
                ),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {
                      Navigator.pop(context);
                  },
                  child: Text("Back",
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