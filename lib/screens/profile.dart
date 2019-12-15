import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/models/income_chart.dart';
import 'package:flutter_app/widgets/bar_chart.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  Widget buildTextField(String text, String value) {
    return SizedBox(
              width: double.infinity,
              child: new Text(text, textAlign: TextAlign.left, )
            );
  }  

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
      income: 6,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SubscriberSeries(
      day: "5",
      income: 7,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
     SubscriberSeries(
      day: "6",
      income: 2,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SubscriberSeries(
      day: "7",
      income: 0,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
     SubscriberSeries(
      day: "8",
      income: 5,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    )
];
    
    return Scaffold(
      body: SingleChildScrollView( //add to Scroll whole screen
        child: Column(
          children: <Widget> [
            new AppBar(
                centerTitle: true,
                backgroundColor: Color(0xff98c1d9),
                title: new Text(
                  'GivnGo',
                  style: TextStyle(),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30),
              ),          
              SizedBox(
                width: double.infinity,
                child: new CircleAvatar(
                  maxRadius: mediaQuery.size.height * 0.15,
                  backgroundColor: Colors.purple,
                  child: Text('AB')
                ),
              ),
              SizedBox(height: 30),
              new Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(7.0),
                color: Color(0xff2de1c2),
                child: MaterialButton(
                  minWidth: mediaQuery.size.width / 3 ,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {},
                  child: Text("Edit Profile", textAlign: TextAlign.center,
                  // color: Color(),
                  // style: style.copyWith(
                  // //     color: Colors.white, 
                  // fontWeight: FontWeight.bold)
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.all(30),
                child: buildTextField("Username", "aabiro")
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: buildTextField("Password", "******")
              ),
              new IncomeChart(
                  data: data
              )
          ],
        ),
      )
    );
  }
}