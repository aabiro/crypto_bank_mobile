import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;

class AlertScreen extends StatefulWidget {
  static final routeName = 'bike_alert';
  @override
  _AlertScreenState createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  // List<Alert> alerts = [
  //   // Bike(1, "bike 1", 1919, true, true, false, "www."),
  //   // Bike(2, "bike 2", 1919, true, true, false, "www.")
  // ];
  List alerts = [];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Constants.mainColor,
            title: new Text(
              'Alerts',
              style: TextStyle(),
            ),
        ),
        body: SizedBox(
          height: mediaQuery.size.height,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ListView(
              children: alerts.map((b) {
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Constants.accentColor,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          b.model.toString(),
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w800,
                              fontSize: 20),
                        ),
                      ),
                      Align(
                        //only show if they are lenders
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                            width: mediaQuery.size.width * 0.15,
                            height: mediaQuery.size.height * 0.15,
                            child: Icon(
                              Icons.error_outline,
                              color: Colors.redAccent,
                            )),
                      ),
                      Align(
                        //only show if they are lenders
                        alignment: Alignment.topRight,
                        child: SizedBox(
                          width: mediaQuery.size.width * 0.15,
                          height: mediaQuery.size.height * 0.15,
                          child: IconButton(
                              //my location ocation searching gps fixed gps not fixed error error outline
                              icon: Icon(Icons.arrow_forward),
                              color: Constants.accentColor,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      fullscreenDialog: true,
                                      builder: (context) => HomeScreen(),
                                      maintainState: false),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ));
  }
}