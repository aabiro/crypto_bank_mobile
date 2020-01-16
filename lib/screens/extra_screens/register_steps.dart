
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserStepsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 100.0,
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 15.0),
                RichText(
                  text: TextSpan(
                    text: 'Hello ',
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: 'User,', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      TextSpan(text: ' we just have a few more questions!', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0),
                MaterialButton(
                  height: 45.0,
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {
                    Navigator.pushNamed(context, '/register/info');
                  },
                  child: Text("Ok!",
                      textAlign: TextAlign.center
                  ),
                ),
                MaterialButton(
                  height: 45.0,
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Back",
                      textAlign: TextAlign.center
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}