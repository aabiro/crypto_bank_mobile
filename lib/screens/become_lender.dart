import 'package:flutter/material.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;

class PlansScreen extends StatelessWidget {
  static const routeName = '/plans';

  Widget buildCard(String title, String text, String priceText) {
    Color greyText = Colors.blueGrey;
    return Card(
      child: InkWell(
        splashColor: Constants.accentColor,
        onTap: () {},
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
                      fontFamily: 'Comfortaa',
                      fontSize: 25),
                ),
              ]),
            ],
          ),
        ),

        // textAlign: Alignment.center
      ),
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
                padding: EdgeInsets.all(10),
                child: Text(
                  "Get Started Today!",
                  style: TextStyle(
                      color: Constants.mainColor,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: buildCard(
                      'Individual Plan',
                      'Single lock delivery\nSet up support\nSet your area and start lending',
                      "\$ 19.99")),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: buildCard(
                      'Company Plan',
                      'Control your own fleet of bikes\nCustomize your locks\nDiscounted price per lock',
                      "\$ 5.99 per lock")),
            ],
          ),
        )
      );
  }
}
