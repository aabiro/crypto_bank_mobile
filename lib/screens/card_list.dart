import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/cards_helper.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/providers/bikes.dart';
import 'package:flutter_app/providers/user_card.dart';
import 'package:flutter_app/providers/user_cards.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:flutter_app/widgets/empty_list.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
    final cardProv = Provider.of<UserCards>(context);
    cards = cardProv.userCards;
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
                height: mediaQuery.size.height * 0.45,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Container(
                    child: ListView(
                      // physics: NeverScrollableScrollPhysics(),
                      // shrinkWrap: true,
                      // scrollDirection: Axis.vertical,
                      children: cards != null && cards.length > 0
                          ? cards?.map(
                              (c) {
                                return Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: SizedBox(
                                    child: Dismissible(
                                      // crossAxisEndOffset: 180.0,
                                      dismissThresholds: {
                                        DismissDirection.endToStart: 5.5
                                      },
                                      movementDuration:
                                          Duration(milliseconds: 1500),
                                      confirmDismiss:
                                          (DismissDirection direction) async {
                                        print('confirming dismiss ..');
                                        return await _showDialog();
                                      },
                                      key: ValueKey(c.id),
                                      direction: DismissDirection.endToStart,
                                      onDismissed: (direction) {
                                        cardProv.deleteUserCard(c.id);
                                      },
                                      background: Container(
                                        color: Colors.red,
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.only(right: 20),
                                        margin: EdgeInsets.all(4),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                        print(c.id);
                                        print(c);
                                        cardProv.updateDefault(c.id, c);
                                                },
                                          child: Card(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                  vertical: 10,
                                                  horizontal: 15,
                                                ),
                                                decoration: BoxDecoration(
                                                    ),
                                                padding: EdgeInsets.all(10),
                                                child: AutoSizeText(
                                                  "Credit Card\n ending in ${c.lastFourDigits}",
                                                  textAlign: TextAlign.center,
                                                  // ,
                                                  style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 15),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 0, 30, 0),
                                                child: Text(
                                                  c.isDefault != null &&
                                                          c.isDefault == true
                                                      ? "Default"
                                                      : "",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      // fontSize: 40,
                                                      color: Constants
                                                          .optionalColor,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                  );
                              },
                            )?.toList()
                          : [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[EmptyListItem("cards")],
                                ),
                              ),
                            ].toList(),
                    ),

                  ),
                ),
              ),
              Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      // child: Hero(
      //   tag: "bike3",
      child: Card(
        child: InkWell(
          // onTap: () => 
          // //  Navigator.push(
          // //         context,
          // //         MaterialPageRoute(
          // //             fullscreenDialog: true,
          // //             builder: (context) => BikeDetailScreen(widget.bike),
          // //             maintainState: false),),


          // // Navigator.of(context).pushNamed(
          // //   BikeDetailScreen.routeName,
          // //   arguments: BikeDetailScreen(bike.bikeId),
          // ),
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            width: double.infinity,
            height: 85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Image.asset(
                        'assets/squareinappblue.png',
                        height: 50,
                    ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text(
                        'In-App Payments\nwith Square',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w800,
                            fontSize: 15),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    //   child: Icon(Icons.error_outline, color: Colors.red),
                    // ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Icon(Icons.arrow_forward, color: Constants.optionalColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
              SizedBox(
                height: mediaQuery.size.height * 0.15,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) => CreditCardScreen(),
                                    maintainState: false));
                            // print('update/edit bike id: $id');
                            // bike.name = name;
                            // bike.model = type;
                            // bikeProv.updateBike(id, bike); //update existing bike
                            // Navigator.of(context).popAndPushNamed(CreditCardScreen.routeName);
                          },
                          child: Text("Add Card",
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> _showDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Text(
            "Are you sure you want to remove this card?",
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
                    Navigator.of(context).pop(true);
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
                    Navigator.of(context).pop(false);
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
