import 'package:flutter/material.dart';
import 'package:flutter_app/providers/authentication.dart';
import 'package:flutter_app/screens/home.dart';
import 'dart:async';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:flutter_app/widgets/generic_screen.dart';
import 'package:provider/provider.dart';

class JourneyScreen extends StatefulWidget {
  static const routeName = '/journey';
  // String bikeId;
  JourneyScreen();
  Timer _tripTimer;

  @override
  _JourneyScreenState createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen> {
  String _timeString = "2 min 5 sec";
  String _getCost = "\$ 4.99";
  var user;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
        user = Provider.of<Authentication>(context);
      });
    _timeString =
        "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
    // Timer _t;
    Timer.periodic(Duration(seconds: 1), (_tripTimer) => _getCurrentTime());
    super.initState();
  }

  @override
  void dispose() {
    //and on stop button
    setState(() {
      _timeString = null;
    });
    // _tripTimer.cancel(); need to cancel this memory leak
    //??
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
                  color: Constants.optionalColor,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 28),
            ),
          )
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final JourneyScreen args = ModalRoute.of(context).settings.arguments;
    // final bId = args.bikeId;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        backgroundColor: Constants.mainColor,
        title: Text(
          'GivnGo',
          style: TextStyle(),
        ),
      ),
      body: 
      Stack(
        children: <Widget>[
          SizedBox(
          height: mediaQuery.size.height,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            //make this a list view builder!!
            child: Column(
              children: <Widget>[
                  buildCard("Time of Journey", _timeString), //causing text error
                  buildCard("Total Price of Journey", _getCost),
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('Lock your bike to end the trip!', textAlign: TextAlign.center, style: TextStyle(
                        color: Colors.blueGrey,
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.w800),),
                    ),

                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
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
                        setState(() {
                          user.isOnTrip = false;
                          _timeString = null;
                          // print('use : $user in the journey screen');
                          // print('user.isOnTrip : ${user.isOnTrip} in the journey screen');
                        }
                        );
                        //run disposing of timer here
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GenericScreen(
                                'regular',
                                'Trip Summary',
                                'Ok',
                                'assets/gnglogo.png',
                                '/home'),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            )
      
          ),
        ),

        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: SizedBox(
                width: double.infinity,
                height: mediaQuery.size.height * 0.1,
                child: RaisedButton(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0)),
                       onPressed: () {
                         print('use : $user in the journey screen');
                       print('user.isOnTrip : ${user.isOnTrip} in the journey screen');
                       Navigator.of(context).pushNamed(MapScreen.routeName);
                  },
                  textColor: Colors.white,
                  color: Constants.accentColor,
                  child:Text('Go to Map',
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 15)) ,
                ),
              ),
            ),
          ),
        ],
          
      ),
    );
  }
}
