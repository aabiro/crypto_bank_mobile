import 'package:flutter/material.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'bike_list.dart';

class ActivationCompleteScreen extends StatelessWidget {
  static const routeName = '/activation_complete';
  ActivationCompleteScreen();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff673AB7),
        title: new Text(
          'Activate Ride',
          style: TextStyle(),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              })
        ],
      ),
      body: Column(
        children: <Widget>[      
          Padding(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
            child: Text(
              "Done!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w800,
                  color: Constants.mainColor,
                  fontSize: 25),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 20),
            child: Text(
                'Congratulations, your bike has been activated.\nYou are now ready to lend your bike on the platform!\n\nYou can now manage this ride in your Settings.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.blueGrey,
                    fontSize: 15)),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              width: mediaQuery.size.width * 0.3,
              height: mediaQuery.size.height * 0.07,
              child: RaisedButton(
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0)),
                textColor: Colors.white,
                color: Constants.accentColor,
                child: const Text(
                  'Ok',
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                onPressed: () {
                  Navigator.popAndPushNamed(context, BikeList.routeName);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
