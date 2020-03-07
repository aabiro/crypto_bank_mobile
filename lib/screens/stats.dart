import 'package:flutter/material.dart';
import 'package:flutter_app/models/income_chart.dart';
import 'package:flutter_app/providers/journey.dart';
import 'package:flutter_app/providers/journeys.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/widgets/bar_chart.dart';
import 'package:flutter_app/widgets/generic_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import "package:collection/collection.dart";

import 'direct_deposit.dart';

class StatsScreen extends StatefulWidget {
  static const routeName = '/stats';

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  bool _isLoading = false;
  Future<bool> statsReady;
  var _init = true;

  Future<bool> finishLoading() async {
    return true;
  }

  @override
  void initState() {
    if (_init) {
      setState(() {
        _isLoading = true;
      });
      Future.delayed(Duration.zero).then(
        (_) {
          Provider.of<Journeys>(context).getJourneys();
        },
      );
      Future.delayed(Duration.zero).then(
        (_) {
          Provider.of<Journeys>(context).getJourneys(asLender: true);
          if (mounted) {
            setState(() {
              _isLoading = false;
              statsReady = finishLoading();
            });
          }
        },
      );
      _init = false;
      super.initState();
    }
  }

  void groupedStats({bool weeklyGrouped = false}) {
    List<Journey> result = [];
    var newResult = <dynamic, List<Journey>>{};
    if (weeklyGrouped == true) {
      result = Provider.of<Journeys>(context).ownerJourneys;
    } else {
      //grouped daily in last week
      var bresult = Provider.of<Journeys>(context).ownerJourneys.where((journey) =>
          (journey.startTime
              .isAfter(journey.startTime.subtract(Duration(days: 30)))) &&
          (journey.endTime.isBefore(DateTime.now())));
      newResult = groupBy(bresult, (obj) => obj.dayOfTheWeek);
      print('weekly grouped results : $result');
      print('weekly grouped results grouped : $newResult');
    }
    // return newResult;
  }

  List<double> getTotalTimeAndEarned(List<Journey> list) {
    double totalTime = 0.0;
    double totalEarned = 0.0;
    if (list != null) {
      list.forEach((journey) {
        print(
            'id : ${journey.id} , totalTime : ${journey.tripLength} , tripTotal : ${journey.tripTotal}');
        if (journey.hasEnded == true &&
            journey.tripLength != null &&
            journey.tripTotal != null) {
          totalTime += journey.tripLength;
          totalEarned += journey.tripTotal;
        }
      });
    }
    // print('total earned : $totalEarned');
    return [totalTime, totalEarned];
  }

  @override
  Widget build(BuildContext context) {
    final journeysProv = Provider.of<Journeys>(context);
    final mediaQuery = MediaQuery.of(context);
    final journeysAsUser = journeysProv.userJourneys;
    final journeysAsOwner = journeysProv.ownerJourneys;
    String totalTrips = journeysAsUser.length.toString();
    List<double> totalTimeAndEarnedAsLender =
        getTotalTimeAndEarned(journeysAsOwner);
    String totalTimeAsUser =
        getTotalTimeAndEarned(journeysAsUser)[0].toString();

    // int totalTimeAsLender = totalTimeAndEarnedAsLender[0];
    String calories = (double.parse(totalTimeAsUser) * 12.0)
        .toStringAsFixed(0); //12 caories per minute
    String kilometers = (double.parse(totalTimeAsUser) * 0.35)
        .toStringAsFixed(1); //0.35 km per minute
    String earned = getTotalTimeAndEarned(journeysAsUser)[1].toStringAsFixed(2);
    String totalEarned = "\$$earned";
    groupedStats();

    // print('grouped stats : $groupedStatsList');

    // print('user journeys : $journeysAsUser');
    // print('owner journeys : $journeysAsOwner');
    // print(totalTrips);
    // print('total time as user : $totalTimeAsUser');
    // print('total earned2 : $totalTimeAndEarnedAsLender');

    final List<SubscriberSeries> data = [
      SubscriberSeries(
        day: "1",
        income: 5,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue),
      ),
      SubscriberSeries(
        day: "2",
        income: 3,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue),
      ),
      SubscriberSeries(
        day: "3",
        income: 8,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue),
      ),
      SubscriberSeries(
        day: "4",
        income: 0,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue),
      ),
      SubscriberSeries(
        day: "5",
        income: 7,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue),
      ),
      SubscriberSeries(
        day: "6",
        income: 0,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue),
      ),
      SubscriberSeries(
        day: "7",
        income: 1,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue),
      ),
    ];
    Map<String, double> dataMap = new Map();
    dataMap.putIfAbsent("Completed", () => 5);
    dataMap.putIfAbsent("In Progress", () => 3);
    // dataMap.putIfAbsent("Xamarin", () => 2);
    // dataMap.putIfAbsent("Ionic", () => 2);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: statsReady,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  //add to Scroll whole screen
                  child: Column(children: <Widget>[
                    new AppBar(
                      centerTitle: true,
                      backgroundColor: Constants.mainColor,
                      title: new Text(
                        'My Stats',
                        style: TextStyle(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                      child: Text(
                        'Health Metrics',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Comfortaa',
                        ),
                      ),
                    ),
                    SizedBox(
                      // height: FlexFit.loose,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(30),
                                        child: Text(
                                          'Calories',
                                          style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w800,
                                            fontFamily: 'Comfortaa',
                                          ),
                                        ),
                                      ),
                                      Text(
                                        calories != null ? calories : '',
                                        style: TextStyle(
                                          color: Constants.mainColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'Comfortaa',
                                        ),
                                      ),
                                      SizedBox(height: 30),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(30),
                                        child: Text(
                                          'Trips',
                                          style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w800,
                                            fontFamily: 'Comfortaa',
                                          ),
                                        ),
                                      ),
                                      Text(
                                        totalTrips != null ? totalTrips : '',
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Column(children: <Widget>[
                                    Column(children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(30),
                                        child: Text(
                                          'Kilometers',
                                          style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w800,
                                            fontFamily: 'Comfortaa',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 30),
                                        child: Text(
                                          kilometers != null ? kilometers : '',
                                          style: TextStyle(
                                            color: Constants.mainColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                            fontFamily: 'Comfortaa',
                                          ),
                                        ),
                                      ),
                                      // SizedBox(height: 30),
                                    ]),
                                  ])
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // child:
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Financal Charts',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Comfortaa',
                        ),
                      ),
                    ),
                    IncomeChart(data: data),
                    SizedBox(
                      width: double.infinity,
                      height: 240,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "Total Earned",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              // SizedBox(height: 10),
                              Text(
                                totalEarned != null ? totalEarned : '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Constants.mainColor,
                                    fontFamily: 'Comfortaa',
                                    fontWeight: FontWeight.w900,
                                    fontSize: 45),
                              ),
                              SizedBox(
                                  width: mediaQuery.size.width * 0.5,
                                  height: mediaQuery.size.height * 0.07,
                                  child: RaisedButton(
                                    elevation: 0.5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.0)),
                                    // icon: Icon(Icons.attach_money),
                                    textColor: Colors.white,
                                    color: Constants.accentColor,
                                    child: const Text('Claim Credit',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(DirectDeposit.routeName);
                                    },
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                );
            } else if (snapshot.hasError) {
              return GenericScreen('regular', 'There was an error!', 'Ok',
                  'assets/gnglogo.png', '/login');
            }
            return SpinKitPulse(color: Constants.mainColor);
            }),
      ),
    );
  }
}
