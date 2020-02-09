import 'package:flutter/material.dart';
import 'package:flutter_app/providers/authentication.dart';
import 'package:flutter_app/providers/bike.dart';
import 'package:flutter_app/providers/bikes.dart';
import 'package:flutter_app/screens/order_complete.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:flutter_app/widgets/dropdown.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class EditBike extends StatefulWidget {
  static const routeName = '/edit_bike';
  final String id;

  EditBike([this.id]);
  @override
  _EditBikeState createState() => _EditBikeState();
}

class _EditBikeState extends State<EditBike> {
  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final conditionController = TextEditingController();


  buildInputField(TextEditingController controller, String hintText, String initialValue) {
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
        // initialValue: initialValue,
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
    final list = Constants.bikeTypes;
    var dropdownValue = list.first;
    final bikeProv = Provider.of<Bikes>(context);
    final bike = bikeProv.findById(widget.id);
    final nameField = buildInputField(nameController, "Name of Bike", bike.name != null ? bike.name : "");
    // final typeField = buildInputField(typeController, "Type");
    // final conditionField = buildInputField(conditionController, "Condition");
    String name = nameController.text;

    String type = typeController.text;
    // String condition = conditionController.text; //add or image upload instead...
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        //add to Scroll whole screen
        child: Column(children: <Widget>[
          new AppBar(
            centerTitle: true,
            backgroundColor: Color(0xff673AB7),
            title: new Text(
              'Edit Bike',
              // planType,
              style: TextStyle(),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: new CircleAvatar(
                  maxRadius: mediaQuery.size.height * 0.15,
                  backgroundColor: Color(0xff9575CD),
                  child: Text('AB',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w900)),
                ),
              ),
            ),
          SizedBox(height: 15.0),
          // buildInputField(nameController, 'Name of Bike'),
          nameField,
          SizedBox(height: 15.0),
          // buildInputField(typeController, 'Type'),
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
                      // isExpanded = true,
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
          // BuildDropdown(dropdownValue, list),
          SizedBox(height: 15.0),
          // buildInputField(conditionController, 'Condition'),
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
                print('update/edit bike id: ${widget.id}');
                  print(dropdownValue);
                  bike.name = name;
                  bike.model = dropdownValue;
                  bikeProv.updateBike(widget.id, bike); //update existing bike
                  Navigator.of(context).pop();
              },
              child: Text(
                "Save",
                textAlign: TextAlign.center,
                style: TextStyle(
                    // fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.w900),
              ),
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