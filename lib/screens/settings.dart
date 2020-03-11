import 'package:flutter/material.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
        return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          new AppBar(
            centerTitle: true,
            backgroundColor: Constants.mainColor,
            title: new Text(
              'Settings',
              style: TextStyle(),
            ),
          ),
          SizedBox(
            height: 20,
          ),          
          Padding(
            padding: EdgeInsets.all(20),
            child: OutlineButton(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              onPressed: _showDialog,
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
    ),);
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
          title: new Text(
            "Are you sure you want to delete your account?",
            style:
                TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                OutlineButton(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  onPressed: () {
                  },
                  child: Text(
                    "Yes",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Constants.mainColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ),
                ),
                OutlineButton(
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
            ),
          ),
        );
      },
    );
  }
}