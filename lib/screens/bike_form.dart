import 'package:flutter/material.dart';
import 'package:flutter_app/providers/authentication.dart';
import 'package:flutter_app/providers/bike.dart';
import 'package:flutter_app/providers/bikes.dart';
import 'package:flutter_app/screens/order_complete.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:provider/provider.dart';
import './add_credit_card.dart';
import 'package:numberpicker/numberpicker.dart';

import 'activation_complete.dart';

class BikeFormScreen extends StatefulWidget {
  static const routeName = '/bike_form';
  String qrCode;
  BikeFormScreen(this.qrCode);

  @override
  _BikeFormScreenState createState() => _BikeFormScreenState();
}

class _BikeFormScreenState extends State<BikeFormScreen> {
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
    final nameController = TextEditingController();
    final conditionController = TextEditingController();
    final typeController = TextEditingController();
    String name = nameController.text;
    // String password = myPasswordController.text;
    // final countryController = TextEditingController();
    // final zipController = TextEditingController();

    final BikeFormScreen args =
        ModalRoute.of(context).settings.arguments;
    final qrCode = args.qrCode;

    return Scaffold(
      body: SingleChildScrollView(
        //add to Scroll whole screen
        child: Column(children: <Widget>[
          new AppBar(
            centerTitle: true,
            backgroundColor: Color(0xff673AB7),
            title: new Text(
              'Bike Detail',
              // planType,
              style: TextStyle(),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Text(
              'Bike details',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 15,
                fontWeight: FontWeight.w800,
                fontFamily: 'OpenSAns',
              ),
            ),
          ),
          buildInputField(nameController, 'Name of Bike'),
          SizedBox(height: 15.0),
          buildInputField(typeController, 'Type'),
          SizedBox(height: 15.0),
          buildInputField(conditionController, 'Condition'),
          SizedBox(height: 15.0),
          // buildInputField(countryController, 'Country'),
          // SizedBox(height: 15.0),
          // buildInputField(zipController, 'Zip Code'),
          // SizedBox(height: 15.0),
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
                      isActive: true,
                      name: name,
                    ),);
                    // Provider.of<Authentication>(context).userId,
                    // Provider.of<Authentication>(context).accessToken);
                Navigator.of(context).popAndPushNamed(
                    ActivationCompleteScreen.routeName);
              },
              child: Text("Next",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      // fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),),
              // color: Color(),
              // style: style.copyWith(
              // //     color: Colors.white,
              // fontWeight: FontWeight.bold)
              // ),
            ),
          ),
        ]),
      ),
    );
  }
}
