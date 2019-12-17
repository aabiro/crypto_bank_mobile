import 'package:flutter/material.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;

import 'order_locks.dart';

class PlansScreen extends StatelessWidget {
  static const routeName = '/plans';

  Widget buildCard(String title, String text, String priceText, BuildContext context) {
    Color greyText = Colors.blueGrey;
    return 
    Container(child: 
    Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        // splashColor: Constants.accentColor,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderLocksScreen(title),
              )
          );// Navigator.of(context).pushNamed(OrderLocksScreen.routeName);
        },
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          height: 200,
          child: Column(
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: greyText,  
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: greyText,  
                    fontFamily: 'Comfortaa',
                    fontSize: 18),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                Text(
                  "From  ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: greyText,  
                      fontFamily: 'Comfortaa',
                      fontSize: 18),
                ),
                Text(
                  priceText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Constants.optionalColor,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Comfortaa',
                      fontSize: 25),
                ),
              ]),
            ],
          ),
        ),

        // textAlign: Alignment.center
      ),
    ),
    decoration: new BoxDecoration(boxShadow: [
        new BoxShadow(
          color: Constants.optionalColor,
          blurRadius: 20.0,
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          //add to Scroll whole screen
          child: Column(
            children: <Widget>[
              AppBar(
                centerTitle: true,
                backgroundColor: Constants.mainColor,
                title: new Text(
                  'Become a Lender',
                  style: TextStyle(),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Text(
                  "Get Started Today!",
                  style: TextStyle(
                      color: Constants.mainColor,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: buildCard(
                      'Individual Plan',
                      'Single lock delivery\nSet up support\nSet your area and start lending',
                      "\$ 19.99 per lock",
                      context)),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                  child: buildCard(
                      'Company Plan',
                      'For larger orders (30+)\nControl your own fleet of bikes\nCustomize your locks\nDiscounted price per lock',
                      "\$ 5.99 per lock",
                      context)),
            ],
          ),
        )
      );
  }
}
