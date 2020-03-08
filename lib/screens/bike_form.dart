import 'package:flutter/material.dart';
import 'package:flutter_app/providers/authentication.dart';
import 'package:flutter_app/providers/bike.dart';
import 'package:flutter_app/providers/bikes.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'activation_complete.dart';

class BikeFormScreen extends StatefulWidget {
  static const routeName = '/bike_form';
  final qrCode;
  BikeFormScreen(this.qrCode);

  @override
  _BikeFormScreenState createState() => _BikeFormScreenState();
}

class _BikeFormScreenState extends State<BikeFormScreen> {
  final nameController = TextEditingController();
  String dropdownValue = "None";

  buildInputField(TextEditingController controller, String hintText) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        obscureText: false,
        controller: controller,
        decoration: InputDecoration(
          labelText: hintText,
          hintStyle: TextStyle(
            color: Color(0xff2196F3),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final list = Constants.bikeTypes;
    String name = nameController.text.toString().trim();

    int min = 0;
    int max = Constants.torontoLocations.length;
    Random rnd = new Random();
    int randIndex = min + rnd.nextInt(max - min);
    LatLng latlng = Constants.torontoLocations[randIndex];
    print(latlng);

    final BikeFormScreen args = ModalRoute.of(context).settings.arguments;
    final qrCode = args.qrCode;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          new AppBar(
            centerTitle: true,
            backgroundColor: Color(0xff673AB7),
            title: new Text(
              'Bike Detail',
              style: TextStyle(),
            ),
          ),
          SizedBox(height: 15.0),
          buildInputField(nameController, 'Name of Bike'),
          SizedBox(height: 15.0),
          Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    "Type",
                    style: TextStyle(fontSize: 15, color: Colors.blueGrey),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: SizedBox(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text(
                        'Type',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w800,
                            fontSize: 18),
                      ),
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_drop_down,
                          color: Constants.mainColor),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w800,
                          fontSize: 18),
                      underline: Container(
                        height: 2,
                        color: Constants.mainColor,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                ),
          SizedBox(height: 30.0),
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(7.0),
            color: Color(0xff2196F3),
            child: MaterialButton(
              minWidth: mediaQuery.size.width / 3,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () {
                Provider.of<Bikes>(context).addBike(
                  Bike(
                      userId: Provider.of<Authentication>(context).userId,
                      qrCode: qrCode, //do this check later
                      isActive: false,
                      name: name == "" || name == null ? 'New Bike' : name,
                      model: dropdownValue,
                      lat: latlng.latitude,
                      lng: latlng.longitude),
                );
                Navigator.of(context)
                    .popAndPushNamed(ActivationCompleteScreen.routeName);
              },
              child: Text(
                "Next",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
