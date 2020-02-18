import 'package:flutter/material.dart';
import 'package:flutter_app/providers/authentication.dart';
import 'package:flutter_app/providers/journey.dart';
import 'package:flutter_app/providers/journeys.dart';
import 'package:flutter_app/screens/home.dart';
import 'dart:async';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:flutter_app/widgets/generic_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class JourneyScreen extends StatefulWidget {
  static const routeName = '/journey';
  String bikeId;
  String userId;
  bool isUserBike;
  Journey journey;
  JourneyScreen({this.journey, this.isUserBike});

  @override
  _JourneyScreenState createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen> {
  String _timeString;
  String _costString;
  String cost;
  final String $cent = String.fromCharCode(0x00A2);
  Future<bool> screenReady;
  Timer _t;
  var user;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      user = Provider.of<Authentication>(context);
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    DateTime journeyStartTime;
    final JourneyScreen args = ModalRoute.of(context).settings.arguments;
    final isUserBike = args.isUserBike;
    Provider.of<Journeys>(context).getCurrentUserJourney().then((response) {
      journeyStartTime = response.startTime;
      Duration timePassed = DateTime.now().difference(journeyStartTime);
      // print(timePassed.inSeconds);
      _costString = isUserBike ? "Free!" : "${(timePassed.inMinutes * .20) + 1}";
      if (timePassed.inMinutes < 1 && timePassed.inSeconds.remainder(60) < 10) {
        _timeString =
            "0${(timePassed.inSeconds.remainder(60))} sec";
      } else if (timePassed.inMinutes >= 1 && timePassed.inSeconds.remainder(60) < 10) {
        _timeString =
            "${timePassed.inMinutes.remainder(60)} : 0${(timePassed.inSeconds.remainder(60))} sec";
      } else if (timePassed.inHours >= 1) {
        _timeString =
            "${timePassed.inHours.remainder(60)} :${timePassed.inMinutes.remainder(60)} : ${(timePassed.inSeconds.remainder(60))} sec";
      } else {
        _timeString =
            "${timePassed.inMinutes.remainder(60)} : ${(timePassed.inSeconds.remainder(60))} sec";
      }



      // if (timePassed.inSeconds.remainder(60) < 10) {
      //   _timeString =
      //       "${timePassed.inMinutes.remainder(60)} : 0${(timePassed.inSeconds.remainder(60))} sec";
      // } else {
      //   _timeString =
      //       "${timePassed.inMinutes.remainder(60)} : ${(timePassed.inSeconds.remainder(60))} sec";
      // }
    });
    _t = Timer.periodic(
        Duration(seconds: 1), (_t) => _getCurrentTimeAndCost(journeyStartTime, isUserBike));
  }

  @override
  void dispose() {
    setState(() {
      _timeString = null;
      _costString = null;
      _t?.cancel();
    });
    super.dispose();
  }

  Future<bool> finishLoading() async {
    return true;
  }

  void _getCurrentTimeAndCost(DateTime journeyStartTime, bool isUserBike) {
    Duration timePassed = DateTime.now().difference(journeyStartTime);
    print(timePassed.inSeconds);
    setState(() {
      //assume < 1 hour for now
      if (timePassed.inMinutes < 1 && timePassed.inSeconds.remainder(60) < 10) {
        _timeString =
            "0${(timePassed.inSeconds.remainder(60))} sec";
      } else if (timePassed.inMinutes >= 1 && timePassed.inSeconds.remainder(60) < 10) {
        _timeString =
            "${timePassed.inMinutes.remainder(60)} : 0${(timePassed.inSeconds.remainder(60))} sec";
      } else {
        _timeString =
            "${timePassed.inMinutes.remainder(60)} : ${(timePassed.inSeconds.remainder(60))} sec";
      }
      // if (timePassed.inMinutes.remainder(60) < 1 && timePassed.inSeconds.remainder(60) < 10) {
      //   _timeString =
      //       "0${(timePassed.inSeconds.remainder(60))} sec";
      // } else if (timePassed.inSeconds.remainder(60) < 10) {
      //   _timeString =
      //       "${timePassed.inMinutes.remainder(60)} : 0${(timePassed.inSeconds.remainder(60))} sec";
      // } else {
      //   _timeString =
      //       "${timePassed.inMinutes.remainder(60)} : ${(timePassed.inSeconds.remainder(60))} sec";
      // }
      cost = ((timePassed.inMinutes * .20) + 1).toStringAsFixed(2);
      _costString = isUserBike ? "Free!" : "\$$cost";
      // "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
      // "${timePassed.inHours}:${timePassed.inMinutes.remainder(60)}:${(timePassed.inSeconds.remainder(60))}";
    });
    screenReady = finishLoading();
  }

  Widget buildCard(String text, String cardInfo) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            height: 120,
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
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Text(
                  cardInfo != null ? cardInfo : '',
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final JourneyScreen args = ModalRoute.of(context).settings.arguments;
    final journey = args.journey;
    final isUserBike = args.isUserBike;
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
      body: Center(
        child: FutureBuilder(
          future: screenReady,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  SizedBox(
                    height: mediaQuery.size.height,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        //make this a list view builder
                        child: Column(
                          children: <Widget>[
                            buildCard("Time of Journey", _timeString),
                            buildCard("Total Price of Journey", _costString),
                            SizedBox(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Lock your bike to end the trip!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontFamily: 'Comfortaa',
                                      fontWeight: FontWeight.w800),
                                ),
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
                                  Provider.of<Journeys>(context).updateJourney(
                                      journey.id,
                                      Journey(
                                          startTime: journey.startTime,
                                          endTime: DateTime.now(),
                                          dayOfTheWeek: DateTime.now().weekday,
                                          bikeId: null,
                                          bikeOwnerId: journey.bikeOwnerId,
                                          userId: journey.userId,
                                          distance: journey.distance,
                                          hasEnded: true,
                                          tripTotal: isUserBike ? 0.0 : double.parse(cost).round(),
                                          tripLength: journey.startTime.difference(DateTime.now()).inMinutes.toDouble().abs()
                                          ),);
                                  setState(() {
                                    _t.cancel();
                                    _timeString = null;
                                    // _costString = null;
                                  });
                                  //run disposing of timer here
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GenericScreen(
                                          'regular',
                                          'Thank you for riding\nwith GivnGo! \n\n Your trip total:\n\n $_costString',
                                          'Ok',
                                          'assets/gnglogo.png',
                                          '/home'),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              // EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child: Text(
                                  "Just \$1.00 to unlock\nOnly 20 ${$cent}/min afterwards",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.blueGrey,
                                      fontSize: 15)),
                            ),
                          ],
                        )),
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
                            Navigator.of(context)
                                .pushNamed(MapScreen.routeName);
                          },
                          textColor: Colors.white,
                          color: Constants.accentColor,
                          child: Text('Go to Map',
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return GenericScreen('regular', 'There was an error!', 'Ok',
                  'assets/gnglogo.png', '/home');
            }
            return SpinKitCircle(color: Constants.mainColor);
          },
        ),
      ),
    );
  }
}
