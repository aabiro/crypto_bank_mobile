import 'package:flutter/material.dart';
import 'package:flutter_app/models/bike.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:http/src/response.dart';
import '../helpers/bike_helper.dart';

class BikeList extends StatefulWidget {
  // BikeList(this.bikes);
  static final routeName = '/bike_list';

  @override
  _BikeListState createState() => _BikeListState();
}

class _BikeListState extends State<BikeList> {
  //get bikes from the db from the user id
  List<Bike> bikes = [
    Bike(1, "bike 1", 1919, true, true, false, "www."),
    Bike(2, "bike 2", 1919, true, true, false, "www.")
  ];

  
  @override
  Widget build(BuildContext context) {
    // Future<void> bikes2 = BikeHelper.getBikes();
    // print(bikes2);


    Future<void> bikes2 = BikeHelper.getBike();
    // print(bikes2);

    // bikes = 
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Constants.mainColor,
            title: new Text(
              'My Bikes',
              style: TextStyle(),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _showDialog();
                  }),
            ]),
        body: SizedBox(
          height: mediaQuery.size.height,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ListView(
              children: bikes.map((b) {
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
                       Align(  //only show if they are lenders
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: mediaQuery.size.width * 0.15,
              height: mediaQuery.size.height * 0.15,
              child: Icon(Icons.error_outline, color: Colors.redAccent,
              semanticLabel: 'Alert!',)
            ),
          ),
                      Align(  //only show if they are lenders
            alignment: Alignment.topRight,
            child: SizedBox(
              width: mediaQuery.size.width * 0.15,
              height: mediaQuery.size.height * 0.15,
              child: IconButton(
                  //my location ocation searching gps fixed gps not fixed error error outline
                  icon: Icon(Icons.arrow_forward),
                  color: Constants.accentColor,
                  
                onPressed: () {}),
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

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Have a GivnGo lock?",
            style:
                TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
          ),
          // content: new Text("Alert Dialog body"),
          actions: <Widget>[
            Column(
              // crossAxisAlignment:CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  // width: MediaQuery.of(context).size.width / 1.2,
                  child: OutlineButton(
                    // minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/camera');
                    },
                    child: Text(
                      "Activate Ride",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Constants.mainColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 16),
                    ),
                  ),
                ),
                OutlineButton(
                  // minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Cancel",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Constants.mainColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ),
                ),
              ],
            )
            // FlatButton(
            //   child: new Text("Close"),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
          ],
        );
      },
    );
  }
}
