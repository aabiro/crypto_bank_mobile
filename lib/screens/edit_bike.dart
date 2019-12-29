import 'package:flutter/material.dart';
import 'package:flutter_app/providers/bike.dart';
import 'package:flutter_app/providers/bikes.dart';
import 'package:flutter_app/widgets/dropdown.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;

class EditBike extends StatelessWidget {
  static const routeName = '/edit_bike';
  final String id;
  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final conditionController = TextEditingController();
  EditBike([this.id]);

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
    final list = Constants.bikeTypes;
    var dropdownValue = list.first;
    final bikeProv = Provider.of<Bikes>(context);
    final bike = bikeProv.findById(id);
    final nameField = buildInputField(nameController, "Name");
    final typeField = buildInputField(typeController, "Type");
    final conditionField = buildInputField(conditionController, "Condition");
    String name = nameController.text;
    String type = typeController.text;
    // String condition = conditionController.text; //add or image upload instead...
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        //add to Scroll whole screen
        child: Column(
          children: <Widget>[
            new AppBar(
              centerTitle: true,
              backgroundColor: Color(0xff673AB7),
              title: new Text(
                'Edit Bike',
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
            Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 30),
                child: nameField,),
            Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: 
                // typeField,
                BuildDropdown(dropdownValue, list, "Type"),
                ),
            Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 30),
                child: conditionField,
            ),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(7.0),
              color: Color(0xff2196F3),
              child: MaterialButton(
                minWidth: mediaQuery.size.width / 3,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () {
                  print('update/edit bike id: $id');
                  bike.name = name;
                  bike.model = type;
                  bikeProv.updateBike(id, bike); //update existing bike
                  Navigator.of(context).pop();
                },
                child: Text("Save",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        // fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.w900)),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}