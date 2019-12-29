import 'package:flutter/material.dart';
import 'package:flutter_app/models/order.dart';
import 'package:flutter_app/screens/order_complete.dart';
import 'package:flutter_app/screens/review_order.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import './add_credit_card.dart';
import 'package:numberpicker/numberpicker.dart';

class OrderLocksScreen extends StatefulWidget {
  static const routeName = '/order';
  String planType; //how to use in state
  // var planArray = [];
  //company plan selector 30-?
  //ind plan 1 - 29

  OrderLocksScreen([this.planType]);

  @override
  _OrderLocksScreenState createState() => _OrderLocksScreenState();
}

class _OrderLocksScreenState extends State<OrderLocksScreen> {
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
    final list = getPlanArray(widget.planType);
    final mediaQuery = MediaQuery.of(context);
    final nameController = TextEditingController();
    final streetController = TextEditingController();
    final cityController = TextEditingController();
    final countryController = TextEditingController();
    final zipController = TextEditingController();
    // var _currentValue;
    // widget.planType == 'Individual Plan' ? _currentValue = 1 : _currentValue = 30;
    var dropdownValue = list.first;
    // var quantity = 1; //take from input of dropdown
    // var lockPrice = 5.99;
    // // this.planType == 'Individual Plan' ? lockPrice = 19.99 : lockPrice = 5.99;
    // widget.planType == 'Individual Plan' ? lockPrice = 19.99 : lockPrice = 5.99;
    // var locksTotal = quantity * lockPrice;
    // var shipping = 2.33;
    // var total = (locksTotal + shipping).toStringAsFixed(2);

    // void next(int )

    // void _showDialog() {
    //   showDialog<int>(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return new NumberPickerDialog.integer(
    //         minValue: 1,
    //         maxValue: 10,
    //         title: new Text("Pick a new price"),
    //         initialIntegerValue: _currentValue,
    //       );
    //     }
    //   ).then((int value)) {
    //     if (value != null) {
    //       setState(() => _currentPrice = value);
    //     }
    //   }
    //   );
    // }

    return Scaffold(
      body: SingleChildScrollView(
        //add to Scroll whole screen
        child: Column(
          children: <Widget>[
            new AppBar(
              centerTitle: true,
              backgroundColor: Color(0xff673AB7),
              title: new Text(
                'Order Locks',
                // planType,
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
              // height: 200,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.center,

                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Quantity',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Comfortaa',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        //       NumberPicker.integer(
                        // initialValue: _currentValue,
                        // minValue: 1,
                        // maxValue: 50,
                        // onChanged: (newValue) =>
                        //     setState(() => _currentValue = newValue)),
                        //     SizedBox(height: 20,),
                        //     Text("Current number: $_currentValue"),
                        // Text(
                        //   'Picker here : 2',
                        //   style: TextStyle(
                        //     color: Constants.mainColor,
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.w800,
                        //     fontFamily: 'Comfortaa',
                        //   ),
                        // ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: DropdownButton<String>(
                            hint: Text(
                              dropdownValue.toString() == null ? "" : dropdownValue.toString(),
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
                        ),
                        SizedBox(height: 0),
                      ],
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
                  fontFamily: 'Comfortaa',
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
                // width: mediaQuery.size.width * 0.5,
                // height: mediaQuery.size.height * 0.,
                child: RaisedButton(
              elevation: 0.5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0)),
              textColor: Colors.white,
              color: Constants.accentColor,
              child: const Text('Review your order',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              onPressed: () {
              final order = Order(quantity: int.parse(dropdownValue), planType: widget.planType);
                // Navigator.of(context).pushNamed(ReviewOrder.routeName);
                          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReviewOrder(order),
              )
          );
              },
            )),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
