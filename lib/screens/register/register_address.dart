import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../models/user.dart';
import 'dart:convert';

// Create a Form widget.
class UserAddressScreen extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<UserAddressScreen> {
  // final _addressInfoFormKey = GlobalKey<FormState>();
  final myCountryController = TextEditingController();
  final myCityController = TextEditingController();
  final myStreetController = TextEditingController();
  final myAddressNumController = TextEditingController();
  final myZipcodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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

    final cityField = TextFormField(
      validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
      controller: myCityController,
      // style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "City",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
              
    );

    final streetField = TextFormField(
      validator: (value) {
              if (value.isEmpty) {
                return 'Please enter street';
              }
              return null;
            },
      // style: style,
      controller: myStreetController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Street",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
              
    );

    final addressNumField = TextFormField(
      validator: (value) {
              if (value.isEmpty) {
                return 'Please enter address';
              }
              return null;
            },
      // style: style,
      controller: myAddressNumController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "House/Apt. Num",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
              
    );

     final zipcodeField = TextFormField(
      validator: (value) {
              if (value.isEmpty) {
                return 'Please enter zipcode';
              }
              return null;
            },
      // style: style,
      controller: myZipcodeController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Zipcode",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
              
    );

    final country = myCountryController.text;
    final city = myCityController.text;
    final street = myStreetController.text;
    final addressNum = myAddressNumController.text;
    final zipcode = myZipcodeController.text;
    final body = "{\"country\":\"Canada\", \"city\": \"London\", \"street\": \"St George\", \"address\": \"300\", \"zipcode\": \"N6A 3A7\"}";
    // final body = "{\"country\":\"$country\", \"city\": \"$city\", \"street\": \"$street\", \"address\": \"$addressNum\", \"zipcode\": \"$zipcode\"}";
    
    Future<void> _updateUser() async {
      final storage = new FlutterSecureStorage();
      String accessToken = await storage.read(key: "access_token");
      String userId = await storage.read(key: "id");
      final url = "http://10.0.2.2:8888/users/$userId";
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
          } else {
            print(json.decode(response.body));
            Navigator.pushNamed(context, '/home');
          }
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
                  height: 50.0,
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 10.0),
                countryField,
                SizedBox(height: 10.0),
                cityField,
                SizedBox(height: 10.0,),
                streetField,
                SizedBox(height: 10.0),
                addressNumField,
                SizedBox(height: 10.0),
                zipcodeField,
                SizedBox(height: 10.0,),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed:_updateUser,             
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