import 'package:flutter/material.dart';
import 'package:flutter_app/models/order.dart';
import 'package:flutter_app/screens/review_order.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;

class OrderLocksScreen extends StatefulWidget {
  static const routeName = '/order';
  String planType;
  OrderLocksScreen([this.planType]);

  @override
  _OrderLocksScreenState createState() => _OrderLocksScreenState();
}

class _OrderLocksScreenState extends State<OrderLocksScreen> {
  final nameController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final zipController = TextEditingController();
  var dropdownValue = "1";

  List getPlanArray(String planType) {
    return widget.planType == 'Individual Plan'
        ? Constants.indPlanArray
        : Constants.compPlanArray;
  }

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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new AppBar(
              centerTitle: true,
              backgroundColor: Color(0xff673AB7),
              title: new Text(
                'Order Locks',
                style: TextStyle(),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                'Order Details',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'OpenSAns',
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'Quantity',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'OpenSans',
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropdownButton<String>(
                            hint: Text(
                              dropdownValue.toString() == null
                                  ? ""
                                  : dropdownValue.toString(),
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
                            items: getPlanArray(widget.planType)
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: Text(
                'Shipping Address',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
            buildInputField(nameController, 'Name'),
            SizedBox(height: 15.0),
            buildInputField(streetController, 'Street'),
            SizedBox(height: 15.0),
            buildInputField(cityController, 'City'),
            SizedBox(height: 15.0),
            buildInputField(countryController, 'Country'),
            SizedBox(height: 15.0),
            buildInputField(zipController, 'Zip Code'),
            SizedBox(height: 15.0),
            SizedBox(
                child: Padding(
              padding: EdgeInsets.all(20),
              child: RaisedButton(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0)),
                textColor: Colors.white,
                color: Constants.accentColor,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('Review your order',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ),
                onPressed: () {
                  final order = Order(
                      quantity: int.parse(dropdownValue),
                      planType: widget.planType);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewOrder(order),
                    ),
                  );
                },
              ),
            )),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
