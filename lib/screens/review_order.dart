import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/order.dart';
import 'package:flutter_app/providers/authentication.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/services/mailer.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:provider/provider.dart';

import 'add_credit_card.dart';
import 'card_list.dart';
import 'order_locks.dart';

class ReviewOrder extends StatelessWidget {
  Order order;
  ReviewOrder(this.order);
  static const routeName = '/review_order';

  Widget buildCard(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          // height: 200,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  'Summary',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      decoration: new BoxDecoration(boxShadow: [
        new BoxShadow(
          color: Constants.optionalColor,
          blurRadius: 5.0,
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Authentication>(context, listen: false);
    final mediaQuery = MediaQuery.of(context);
    var quantity = this.order.quantity; //take from input of dropdown
    var lockPrice = 5.99;
    var _currentValue;
    this.order.planType == 'Individual Plan'
        ? _currentValue = 1
        : _currentValue = 30;
    print(this.order.planType);
    this.order.planType == 'Individual Plan'
        ? lockPrice = 19.99
        : lockPrice = 5.99;
    _currentValue < 30 ? lockPrice = 19.99 : lockPrice = 5.99;
    var locksTotal = (quantity * lockPrice);
    var locksTotalString = locksTotal.toStringAsFixed(2);
    var shipping = 2.33;
    var total = (locksTotal + shipping).toStringAsFixed(2);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        //add to Scroll whole screen
        child: Column(
          children: <Widget>[
            AppBar(
              centerTitle: true,
              backgroundColor: Constants.mainColor,
              title: new Text(
                'Order Locks',
                style: TextStyle(),
              ),
            ),
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
                                    builder: (context) => CardScreen(chooseDefault: true),
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
                'Summary',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Bike Lock x $quantity \$ $locksTotalString",
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
                    // width: mediaQuery.size.width * 0.5,
                    // height: mediaQuery.size.height * 0.07,
                    child: RaisedButton(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0)),
                      textColor: Colors.white,
                      color: Constants.accentColor,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                                              child: Text(
                          'Place your order',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      onPressed: () {
                        this.order.isApproved = true;
                        //add order to db
                        //send mail and show dialog here
                        print(auth.email);
                        Mailer.mailer(auth.email, auth.displayName, '001');
                        _showDialog(context);
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Thank you for your order! You will receive an email with your receipt and bike activation code shortly.",
            style:
                TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
          ),
           shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
          content: SizedBox(
            // height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                OutlineButton(
                  padding: EdgeInsets.all(20),
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed(MapScreen.routeName);
                  },
                  child: Text(
                    "Ok",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Constants.mainColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
