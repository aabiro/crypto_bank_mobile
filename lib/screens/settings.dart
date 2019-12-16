import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bike_list_view.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:flutter_app/widgets/set_location.dart';

import 'become_lender.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      //add to Scroll whole screen
      child: Column(
        children: <Widget>[
          new AppBar(
            centerTitle: true,
            backgroundColor: Constants.mainColor,
            title: new Text(
              'GivnGo',
              style: TextStyle(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Settings',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 30,
                fontWeight: FontWeight.w800,
                fontFamily: 'Comfortaa',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Hero(
              tag: "credit",
              child: Card(
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => BikeList(),
                          maintainState: false)),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    height: 85,
                    child: Column(
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                    'Manage My Rides',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Icon(Icons.arrow_forward,
                                    color: Colors.blueGrey),
                              )
                            ]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(20), child: new SetLocation()),
          Padding(
            padding: EdgeInsets.all(20),
            child: OutlineButton(
              // minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              onPressed: () {
                // Navigator.pushNamed(context, '/delete');
              },
              child: Text(
                "Delete Account",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w800,
                    fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
