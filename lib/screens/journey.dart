import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:flutter_app/widgets/generic_screen.dart';

class JourneyScreen extends StatefulWidget {
  static const routeName = '/journey';
  String bikeId;
  JourneyScreen(this.bikeId);

  @override
  _JourneyScreenState createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen> {
  String _timeString = "2 min 5 sec";
  String _getCost = "\$ 4.99";

  @override
  void initState() {
    _timeString =
        "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getCurrentTime());
    super.initState();
  }

  @override
  void dispose() {
    _timeString = null;  //??
    super.dispose();
  }

  void _getCurrentTime() {
    setState(() {
      _timeString =
          "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
    });
  }

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
              color: Colors.blueGrey,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          Padding(
            padding: EdgeInsets.all(20), 
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
    final JourneyScreen args = ModalRoute.of(context).settings.arguments;
    final bId = args.bikeId;
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
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: buildCard("Total Price of Journey", _getCost),
            ),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text('Lock your bike id: $bId to end the trip!\n\n Or', textAlign: TextAlign.center, style: TextStyle(
                  color: Colors.blueGrey,
                  fontFamily: 'Comfortaa',
                  fontWeight: FontWeight.w800),),
              ),
              
            ),
            RaisedButton(
              elevation: 0.5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              textColor: Colors.white,
              color: Constants.optionalColor,
              child: const Text('Stop Trip',
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w800,
                      fontSize: 18)),
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GenericScreen(
                      'regular',
                      'Trip Summary',
                      'Ok',
                      'assets/gnglogo.png',
                      '/home'
                    ),
              ),
            );
              },
            ),
          ],
        ),
      ),
    );
  }
}
