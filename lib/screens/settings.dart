import 'package:flutter/material.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:flutter_app/widgets/set_location.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( //add to Scroll whole screen
        child: Column(
          children: <Widget> [
            new AppBar(
                centerTitle: true,
                backgroundColor: Constants.mainColor,
                title: new Text(
                  'GivnGo',
                  style: TextStyle(),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30),
              ),          
              // SizedBox(
              //   width: double.infinity,
              //   child: new CircleAvatar(
              //     maxRadius: mediaQuery.size.height * 0.15,
              //     backgroundColor: Color(0xff9575CD),
              //     child: Text('AB', style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 40,
              //       fontWeight: FontWeight.w900)
              //       ),
              //   ),
              // ),
              SizedBox(height: 30),
              // new Material(
              //   elevation: 5.0,
              //   borderRadius: BorderRadius.circular(7.0),
              //   color: Color(0xff2196F3),
              //   child: MaterialButton(
              //     minWidth: mediaQuery.size.width / 3 ,
              //     padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              //     onPressed: () {},
              //     child: Text("Edit Profile", 
              //       textAlign: TextAlign.center,
              //       style: TextStyle(
              //       // fontSize: 40,
              //       color: Colors.white,
              //       fontWeight: FontWeight.w900)
              //       ),
              //   ),
              // ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.all(30),
                child: new SetLocation()
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: OutlineButton(
                  // minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  onPressed: () {
                    // Navigator.pushNamed(context, '/delete');
                  },
                  child: Text("Delete Account", 
                  textAlign: TextAlign.center, 
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w800,
                    fontSize: 16
                    ),
                    ),
                ),
              ),
          ],
        ),
      )
    );
  }
}