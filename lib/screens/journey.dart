import 'package:flutter/material.dart';
import 'dart:async';

class JourneyScreen extends StatefulWidget {
  static const routeName = '/journey';

  @override
  _JourneyScreenState createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen> {
  String _timeString = "2 min 5 sec";
  String _getCost = "\$ 4.99";

  // @override
  // void initState() {
  //   _timeString =
  //       "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
  //   Timer.periodic(Duration(seconds: 1), (Timer t) => _getCurrentTime());
  //   super.initState();
  // }

  // void _getCurrentTime() {
  //   setState(() {
  //     _timeString =
  //         "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
  //   });
  // }

  Widget buildCard(String text, String cardInfo) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        height: 150,
        child: Column(children: <Widget>[
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          Padding(
            padding: EdgeInsets.all(10), 
            child: Text(
              cardInfo,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff2196F3),
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 28),
            ),
          )
        ]
      ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                'GivnGo',
                style: TextStyle(),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: buildCard("Time of Journey", _timeString),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
              child: buildCard("Total Price of Journey", _getCost),
            )
          ],
        ),
      ),
    );
  }
}
