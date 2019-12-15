import 'package:flutter/material.dart';

class PlansScreen extends StatelessWidget {
  static const routeName = '/plans';
  
  Widget buildCard(String text) {
    return Card(
                child: InkWell(
                  splashColor: Color(0xff2de1c2),
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    height: 200, 
                    child: Text(text, textAlign: TextAlign.center, style: TextStyle(
                      fontFamily: 'OpenSans', 
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                      // textAlign: Alignment.center
                    ),
                  ),
                )
              );
  }  

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView( //add to Scroll whole screen
      child: Column(
        children: <Widget>[
          new AppBar(
              centerTitle: true,
              backgroundColor: Color(0xff98c1d9),
              title: new Text(
                'GivnGo',
                style: TextStyle(),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: buildCard('Individual Plan')
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: buildCard('Company Plan')
            ),
          ],
        ),
      )
    );
  }
}