import 'package:flutter/material.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;

import 'order_locks.dart';

class PlansScreen extends StatelessWidget {
  static const routeName = '/plans';

  Widget buildCard(
      String title, String text, String priceText, BuildContext context) {
    Color greyText = Colors.blueGrey;
    return Container(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderLocksScreen(title),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            height: 200,
            child: Column(
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: greyText,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: greyText, fontFamily: 'Comfortaa', fontSize: 18),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "From  ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: greyText,
                            fontFamily: 'Comfortaa',
                            fontSize: 18),
                      ),
                      Text(
                        priceText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Constants.optionalColor,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Comfortaa',
                            fontSize: 25),
                      ),
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
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
                  'Plans',
                  style: TextStyle(),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Text(
                  "Get Started Today!",
                  style: TextStyle(
                      color: Constants.mainColor,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Container(
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         OrderLocksScreen('Individual Plan'),
                        //   ),
                        // ); // Navigator.of(context).pushNamed(OrderLocksScreen.routeName);
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        height: 280,
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Individual Plan',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: Text(
                                'Single lock delivery\nSet up support\nSet your area and start lending',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontFamily: 'Comfortaa',
                                    fontSize: 18),
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "From  ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontFamily: 'Comfortaa',
                                          fontSize: 18),
                                    ),
                                    Text(
                                      "\$ 19.99 per lock",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Constants.optionalColor,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'Comfortaa',
<<<<<<< HEAD
                                          fontSize: 25),
=======
                                          fontSize: 20),
>>>>>>> 849062b8de57ec11fef3c5e4015294d672e50fbe
                                    ),
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                  width: mediaQuery.size.width * 0.5,
                                  height: mediaQuery.size.height * 0.07,
                                  child: RaisedButton(
                                    elevation: 0.5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.0)),
                                    textColor: Colors.white,
                                    color: Constants.accentColor,
                                    child: const Text('Order Now',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              OrderLocksScreen(
                                                  'Individual Plan'),
                                        ),
                                      );
                                    },
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                  child: Container(
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         OrderLocksScreen('Company Plan'),
                          //   ),
                          // ); // Navigator.of(context).pushNamed(OrderLocksScreen.routeName);
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
<<<<<<< HEAD
                          height: 280,
=======
                          height: 300,
>>>>>>> 849062b8de57ec11fef3c5e4015294d672e50fbe
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Company Plan',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              SizedBox(height: 10),
                              Expanded(
                                child: Text(
                                  'For larger orders (30+)\nControl your own fleet of bikes\nCustomize your locks\nDiscounted price per lock',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontFamily: 'Comfortaa',
                                      fontSize: 18),
                                ),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "From  ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontFamily: 'Comfortaa',
                                            fontSize: 18),
                                      ),
                                      Text(
                                        "\$ 5.99 per lock",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Constants.optionalColor,
                                            fontWeight: FontWeight.w800,
                                            fontFamily: 'Comfortaa',
<<<<<<< HEAD
                                            fontSize: 25),
=======
                                            fontSize: 20),
>>>>>>> 849062b8de57ec11fef3c5e4015294d672e50fbe
                                      ),
                                    ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    width: mediaQuery.size.width * 0.5,
                                    height: mediaQuery.size.height * 0.07,
                                    child: RaisedButton(
                                      elevation: 0.5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.0)),
                                      textColor: Colors.white,
                                      color: Constants.accentColor,
                                      child: const Text('Order Now',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OrderLocksScreen(
                                                    'Company Plan'),
                                          ),
                                        );
                                      },
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }
}
