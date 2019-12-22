import 'package:flutter/material.dart';
import 'package:flutter_app/screens/order_complete.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import './add_credit_card.dart';
import 'package:numberpicker/numberpicker.dart';

class OrderLocksScreen extends StatefulWidget {
  static const routeName = '/order';
  final planType;  //how to use in state 
  //company plan selector 30-?
  //ind plan 1 - 29

  OrderLocksScreen(this.planType);

  @override
  _OrderLocksScreenState createState() => _OrderLocksScreenState();
}

class _OrderLocksScreenState extends State<OrderLocksScreen> {
  

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
    final streetController = TextEditingController();
    final cityController = TextEditingController();
    final countryController = TextEditingController();
    final zipController = TextEditingController();
    var quantity = 1; //take from input of dropdown
    var lockPrice = 5.99;
    var _currentValue = 1;
    // this.planType == 'Individual Plan' ? lockPrice = 19.99 : lockPrice = 5.99;
    _currentValue < 30 ? lockPrice = 19.99 : lockPrice = 5.99;
    var locksTotal = quantity * lockPrice;
    var shipping = 2.33;
    var total = (locksTotal + shipping).toStringAsFixed(2);

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
        child: Column(children: <Widget>[
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
              'Review your order',
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
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Comfortaa',
                          ),
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
                      Text(
                        'Picker here : 2',
                        style: TextStyle(
                          color: Constants.mainColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Comfortaa',
                        ),
                      ),
                      SizedBox(height: 20),
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
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Text(
              'Payment Method',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 25,
                fontWeight: FontWeight.w800,
                fontFamily: 'Comfortaa',
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Credit Card\n ending in XXXX",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontFamily: 'Comfortaa',
                            // fontWeight: FontWeight.w900,
                            fontSize: 15),
                      ),
               OutlineButton(
              // minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => CreditCardScreen(),
                      maintainState: false));
              },
              child: Text(
                "Change",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Constants.mainColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 16),
              ),
            ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Text(
              'Order Summary',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 25,
                fontWeight: FontWeight.w800,
                fontFamily: 'Comfortaa',
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Bike Lock x $quantity \$ $locksTotal",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontFamily: 'Comfortaa',
                        // fontWeight: FontWeight.w900,
                        fontSize: 15),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Shipping \$ $shipping",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontFamily: 'Comfortaa',
                        // fontWeight: FontWeight.w900,
                        fontSize: 15),
                  ),
                  SizedBox(height: 5),
                  new Divider(
                    color: Colors.blueGrey,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Total \$ $total",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontFamily: 'Comfortaa',
                        // fontWeight: FontWeight.w900,
                        fontSize: 15),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                      width: mediaQuery.size.width * 0.5,
                      height: mediaQuery.size.height * 0.07,
                      child: RaisedButton(
                        elevation: 0.5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0)),
                        textColor: Colors.white,
                        color: Constants.accentColor,
                        child: const Text('Place your order',
                            style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(OrderCompleteScreen.routeName);
                        },
                      )),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

// class OrderLocksScreen extends StatelessWidget {
//   static const routeName = '/order';
//   final planType;

//   OrderLocksScreen(this.planType);

//   buildInputField(TextEditingController controller, String hintText) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
//       child: TextFormField(
//         validator: (value) {
//           if (value.isEmpty) {
//             return 'Please enter some text';
//           }
//           return null;
//         },
//         obscureText: false,
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: hintText,
//           hintStyle: TextStyle(
//             color: Color(0xff2196F3),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final nameController = TextEditingController();
//     final streetController = TextEditingController();
//     final cityController = TextEditingController();
//     final countryController = TextEditingController();
//     final zipController = TextEditingController();
//     var quantity = 2; //take from input of dropdown
//     var lockPrice;
//     this.planType == 'Individual Plan' ? lockPrice = 19.99 : lockPrice = 5.99;
//     var locksTotal = quantity * lockPrice;
//     var shipping = 2.33;
//     var total = (locksTotal + shipping).toStringAsFixed(2);
//     var _currentValue = 1;

//     return Scaffold(
//       body: SingleChildScrollView(
//         //add to Scroll whole screen
//         child: Column(children: <Widget>[
//           new AppBar(
//             centerTitle: true,
//             backgroundColor: Color(0xff673AB7),
//             title: new Text(
//               planType,
//               style: TextStyle(),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
//             child: Text(
//               'Review your order',
//               textAlign: TextAlign.left,
//               style: TextStyle(
//                 color: Colors.blueGrey,
//                 fontSize: 25,
//                 fontWeight: FontWeight.w800,
//                 fontFamily: 'OpenSAns',
//               ),
//             ),
//           ),
//           SizedBox(
//             // height: 200,
//             width: double.infinity,
//             child: Padding(
//               padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 // crossAxisAlignment: CrossAxisAlignment.center,

//                 children: <Widget>[
//                   Column(
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.all(10),
//                         child: Text(
//                           'Quantity',
//                           style: TextStyle(
//                             color: Colors.blueGrey,
//                             fontSize: 25,
//                             fontWeight: FontWeight.w800,
//                             fontFamily: 'Comfortaa',
//                           ),
//                         ),
//                       ),
//                       NumberPicker.integer(
//                 initialValue: _currentValue,
//                 minValue: 0,
//                 maxValue: 100,
//                 onChanged: (newValue) =>
//                     setState(() => _currentValue = newValue)),
//             new Text("Current number: $_currentValue"),
//                       // Text(
//                       //   'Picker here : 2',
//                       //   style: TextStyle(
//                       //     color: Constants.mainColor,
//                       //     fontSize: 20,
//                       //     fontWeight: FontWeight.w800,
//                       //     fontFamily: 'Comfortaa',
//                       //   ),
//                       // ),
//                       // SizedBox(height: 20),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(0),
//             child: Text(
//               'Shipping Address',
//               textAlign: TextAlign.left,
//               style: TextStyle(
//                 color: Colors.blueGrey,
//                 fontSize: 25,
//                 fontWeight: FontWeight.w800,
//                 fontFamily: 'Comfortaa',
//               ),
//             ),
//           ),
//           buildInputField(nameController, 'Name'),
//           SizedBox(height: 15.0),
//           buildInputField(streetController, 'Street'),
//           SizedBox(height: 15.0),
//           buildInputField(cityController, 'City'),
//           SizedBox(height: 15.0),
//           buildInputField(countryController, 'Country'),
//           SizedBox(height: 15.0),
//           buildInputField(zipController, 'Zip Code'),
//           SizedBox(height: 15.0),
//           Padding(
//             padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
//             child: Text(
//               'Payment Method',
//               textAlign: TextAlign.left,
//               style: TextStyle(
//                 color: Colors.blueGrey,
//                 fontSize: 25,
//                 fontWeight: FontWeight.w800,
//                 fontFamily: 'Comfortaa',
//               ),
//             ),
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: Padding(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       Text(
//                         "Credit Card\n ending in XXXX",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             color: Colors.blueGrey,
//                             fontFamily: 'Comfortaa',
//                             fontWeight: FontWeight.w900,
//                             fontSize: 15),
//                       ),
//                OutlineButton(
//               // minWidth: MediaQuery.of(context).size.width,
//               padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       fullscreenDialog: true,
//                       builder: (context) => CreditCardScreen(),
//                       maintainState: false));
//               },
//               child: Text(
//                 "Change",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     color: Constants.mainColor,
//                     fontWeight: FontWeight.w800,
//                     fontSize: 16),
//               ),
//             ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
//             child: Text(
//               'Order Summary',
//               textAlign: TextAlign.left,
//               style: TextStyle(
//                 color: Colors.blueGrey,
//                 fontSize: 25,
//                 fontWeight: FontWeight.w800,
//                 fontFamily: 'Comfortaa',
//               ),
//             ),
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: Padding(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Text(
//                     "Bike Lock x $quantity \$ $locksTotal",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         color: Colors.blueGrey,
//                         fontFamily: 'Comfortaa',
//                         fontWeight: FontWeight.w900,
//                         fontSize: 15),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     "Shipping \$ $shipping",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         color: Colors.blueGrey,
//                         fontFamily: 'Comfortaa',
//                         fontWeight: FontWeight.w900,
//                         fontSize: 15),
//                   ),
//                   SizedBox(height: 10),
//                   new Divider(
//                     color: Colors.blueGrey,
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     "Total \$ $total",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         color: Colors.blueGrey,
//                         fontFamily: 'Comfortaa',
//                         fontWeight: FontWeight.w900,
//                         fontSize: 15),
//                   ),
//                   SizedBox(height: 20),
//                   SizedBox(
//                       width: mediaQuery.size.width * 0.5,
//                       height: mediaQuery.size.height * 0.07,
//                       child: RaisedButton(
//                         elevation: 0.5,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(7.0)),
//                         textColor: Colors.white,
//                         color: Constants.accentColor,
//                         child: const Text('Place your order',
//                             style: TextStyle(
//                                 fontFamily: 'OpenSans',
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18)),
//                         onPressed: () {
//                           Navigator.of(context)
//                               .pushNamed(OrderCompleteScreen.routeName);
//                         },
//                       )),
//                 ],
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }
