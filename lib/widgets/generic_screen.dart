import 'package:flutter/material.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;

class GenericScreen extends StatelessWidget {
  static const routeName = '/generic_screen';
  String type; 
  String mainText; 
  String buttonText; 
  String picPath;
  String goToRouteName;

  GenericScreen(this.type, this.mainText, this.buttonText, this.picPath, this.goToRouteName);
 
  Widget build(BuildContext context) {
    Color buttonColor = Constants.mainColor;
    if (this.type == 'error') {
      buttonColor = Colors.red;
    }
    @override
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff673AB7),
        title: new Text(
          'GivnGo',
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
            padding: EdgeInsets.fromLTRB(30, 60, 30, 20),
            child: Text(
                mainText,
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
                    picPath,
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
                  color: buttonColor,
                  child: Text(
                      buttonText,
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  onPressed: () {
                    Navigator.of(context)
                              .pushNamed(goToRouteName);
                  },
                )),
          )
        ],
      ),
    );
  }
}