import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/providers/bikes.dart';
import 'package:flutter_app/providers/user_card.dart';
import 'package:flutter_app/providers/user_cards.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:provider/provider.dart';

import 'add_credit_card.dart';

class CardScreen extends StatefulWidget {
  static final routeName = 'cards';
  bool chooseDefault;

  CardScreen({this.chooseDefault});

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  var _init = true;
  var _isLoading = false;
  List<UserCard> cards = [];

  @override
  void didChangeDependencies() {
    if (_init) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<UserCards>(context).getUserUserCards().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _init = false;
  }

  @override
  Widget build(BuildContext context) {
    cards = Provider.of<UserCards>(context).userCards;
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Constants.mainColor,
        title: new Text(
          'Cards',
          style: TextStyle(),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: mediaQuery.size.height * 0.1,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                'Choose Default Payment',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: mediaQuery.size.height * 0.5,
          //   child: Padding(
          //     padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          //     child: 
          Column(
              children: <Widget>[
                SizedBox(
            height: mediaQuery.size.height * 0.6,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child:
                Container(
                    child: ListView(
                    // physics: NeverScrollableScrollPhysics(),
                    // shrinkWrap: true,
                    // scrollDirection: Axis.vertical,
                    children: cards?.map(
                      (c) {
                        return Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 15,
                                ),
                                decoration: BoxDecoration(
                                    // border: Border.all(
                                    //   color: Constants.accentColor,
                                    //   width: 2,
                                    // ),
                                    ),
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Credit Card\n ending in ${c.lastFourDigits}",
                                  textAlign: TextAlign.center,
                                  // "Credit Card\n ending in XXXX",
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20),
                                      
                                
                              ),),
                              Padding(
                                padding: EdgeInsets.all(30),
                        child: Text(c.isDefault ? "Default" : "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          // fontSize: 40,
                          color: Constants.optionalColor,
                          fontWeight: FontWeight.w900)),
                              ),
                              
                            ],
                          ),
                        );
                      },
                    )?.toList() ?? [],
                  ),
                ),   ),
          ),
                SizedBox(
                  // height: mediaQuery.size.height * 0.2,
                                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                          Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(7.0),
                            color: Color(0xff2196F3),
                            child: MaterialButton(
                              minWidth: mediaQuery.size.width / 3,
                              // padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              onPressed: () {
                                Navigator.of(context).pop();
                                // print('update/edit bike id: $id');
                                // bike.name = name;
                                // bike.model = type;
                                // bikeProv.updateBike(id, bike); //update existing bike
                                // Navigator.of(context).popAndPushNamed(CreditCardScreen.routeName);

                              },
                              child: Text("Cancel",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      // fontSize: 40,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900)),
                            ),
                          ),
              //  Text("Or",
              //             textAlign: TextAlign.center,
              //             style: TextStyle(
              //                 // fontSize: 40,
              //                 color: Colors.blueGrey,
              //                 fontWeight: FontWeight.w900)),
                    // SizedBox(height: 30,),
                    Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(7.0),
                    color: Color(0xff2196F3),
                    child: MaterialButton(
                      minWidth: mediaQuery.size.width / 3,
                      // padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () {
                        //save default card
                        // print('update/edit bike id: $id');
                        // bike.name = name;
                        // bike.model = type;
                        // bikeProv.updateBike(id, bike); //update existing bike
                        Navigator.of(context).pop();
                      },
                      child: Text("Save",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              // fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.w900)),
                    ),
                      ),
              
                      ],),
                  ),
                ),
              ],
                ),
         
        ],
      ),
    );
  }
}
