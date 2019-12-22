import 'package:flutter/material.dart';
import 'package:flutter_app/models/income_chart.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/widgets/bar_chart.dart';

class StatsScreen extends StatelessWidget {
  static const routeName = '/stats';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
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
      body: SingleChildScrollView(
        //add to Scroll whole screen
        child: Column(children: <Widget>[
          new AppBar(
            centerTitle: true,
            backgroundColor: Color(0xff673AB7),
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
                fontSize: 30,
                fontWeight: FontWeight.w800,
                fontFamily: 'Comfortaa',
              ),
            ),
          ),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Padding(
            padding: EdgeInsets.all(20),
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
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
                            '880',
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
                            '50',
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
                              'Kilometers',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                          ),
                          Text(
                            '30',
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
                fontSize: 30,
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
                      "\$ 7.87",
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
                              borderRadius: BorderRadius.circular(7.0)),
                          // icon: Icon(Icons.attach_money),
                          textColor: Colors.white,
                          color: Constants.accentColor,
                          child: const Text('Claim Credit',
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          onPressed: () {
                            // Navigator.pushNamed(context, '/camera');
                          },
                        )),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
