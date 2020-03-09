import 'package:flutter/material.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;

class OrderCompleteScreen extends StatelessWidget {
  static const routeName = '/order_complete';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff673AB7),
        title: new Text(
          'Givngo',
          style: TextStyle(),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
              })
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(30, 60, 30, 20),
            child: Text(
                'Thank you for your order!\nYour lock will be on it\'s way very soon',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.blueGrey,
                    fontSize: 20)),
          ),
          Padding(
          padding: EdgeInsets.all(5),
            child: SizedBox(
                width: double.infinity,
                height: mediaQuery.size.height * 0.4,
                child: Image.asset(
                    "assets/gnglogopurple.png",
                    fit: BoxFit.contain,
                  ),
            )
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: SizedBox(
                width: mediaQuery.size.width * 0.5,
                height: mediaQuery.size.height * 0.07,
                child: RaisedButton(
                  elevation: 0.5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                  textColor: Colors.white,
                  color: Constants.accentColor,
                  child: const Text('Ok',
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
                  },
                )),
          )
        ],
      ),
    );
  }
}
