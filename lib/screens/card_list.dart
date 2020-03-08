import 'package:flutter/material.dart';
import 'package:flutter_app/providers/authentication.dart';
import 'package:flutter_app/providers/bike.dart';
import 'package:flutter_app/providers/bikes.dart';
import 'package:flutter_app/providers/journey.dart';
import 'package:flutter_app/providers/journeys.dart';
import 'package:flutter_app/providers/user_card.dart';
import 'package:flutter_app/providers/user_cards.dart';
import 'package:flutter_app/screens/journey.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
// import '../theme/secrets.dart' as Secrets;
import 'package:flutter/src/material/card.dart' as Card;
import 'package:flutter_app/widgets/empty_list.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_app/widgets/generic_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
// import 'package:square_in_app_payments/in_app_payments.dart';
// import 'package:square_in_app_payments/models.dart';
import 'add_credit_card.dart';

class CardScreen extends StatefulWidget {
  static final routeName = '/cards';
  bool chooseDefault;
  bool chooseForJourney;
  String barcode;
  CardScreen({this.chooseDefault, this.chooseForJourney, this.barcode});

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  var _init = true;
  var _isLoading = false;
  List<UserCard> cards = [];
  Future<bool> cardsReady;

  Future<bool> finishLoading() async {
    return true;
  }

  // void _pay() {
  //   InAppPayments.setSquareApplicationId(Secrets.squareAppId);
  //   InAppPayments.startCardEntryFlow(
  //     onCardEntryCancel: _cardEntryCancel,
  //     onCardNonceRequestSuccess: _cardNonceRequestSuccess,
  //   );
  // }

  // void _cardNonceRequestSuccess(CardDetails result) {
  //   // Use this nonce from your backend to pay via Square API
  //   print(result.nonce);

  //   final bool _invalidZipCode = false;

  //   if (_invalidZipCode) {
  //     // Stay in the card flow and show an error:
  //     InAppPayments.showCardNonceProcessingError('Invalid ZipCode');
  //   }

  //   InAppPayments.completeCardEntry(
  //     onCardEntryComplete: _cardEntryComplete,
  //   );
  // }

  // void _cardEntryCancel() {
  //   // Cancel
  // }

  // void _cardEntryComplete() {
  //   // Success
  //   print("success card entry complete");
  //   // _resetCounter();
  // }

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
    cardsReady = finishLoading();
    _init = false;
  }

  @override
  Widget build(BuildContext context) {
    final cardProv = Provider.of<UserCards>(context);
    cards = cardProv.userCards;
    final CardScreen args = ModalRoute.of(context).settings.arguments;
    String barcode;
    bool chooseForJourney;
    if (args?.chooseDefault != null && args?.chooseDefault != true) {
      chooseForJourney = args.chooseForJourney;
      barcode = args.barcode;
    }

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
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder(
              future: cardsReady,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
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
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: SizedBox(
                                                  child: Dismissible(
                                                    // crossAxisEndOffset: 180.0,
                                                    dismissThresholds: {
                                                      DismissDirection
                                                          .endToStart: 0.1
                                                    },
                                                    movementDuration: Duration(
                                                        milliseconds: 1000),
                                                    confirmDismiss:
                                                        (DismissDirection
                                                            direction) async {
                                                      return await showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                "Confirm"),
                                                            content: const Text(
                                                                "Are you sure you wish to delete this item?"),
                                                            actions: <Widget>[
                                                              FlatButton(
                                                                  onPressed: () =>
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop(
                                                                              true),
                                                                  child: const Text(
                                                                      "DELETE")),
                                                              FlatButton(
                                                                onPressed: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            false),
                                                                child: const Text(
                                                                    "CANCEL"),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    // confirmDismiss:
                                                    //     (DismissDirection direction) async {
                                                    //   // print('confirming dismiss ..');
                                                    //   return await _showDialog();
                                                    // },
                                                    key: ValueKey(c.id),
                                                    direction: DismissDirection
                                                        .endToStart,
                                                    onDismissed: (direction) {
                                                      cardProv
                                                          .deleteUserCard(c.id);
                                                    },
                                                    background: Container(
                                                      color: Colors.red,
                                                      child: Icon(
                                                        Icons.delete,
                                                        color: Colors.white,
                                                        size: 40,
                                                      ),
                                                      alignment:
                                                          Alignment.centerRight,
                                                      padding: EdgeInsets.only(
                                                          right: 20),
                                                      margin: EdgeInsets.all(4),
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        print(c.id);
                                                        print(c);
                                                        cardProv.updateDefault(
                                                            c.id, c);
                                                      },
                                                      child: Card.Card(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                vertical: 10,
                                                                horizontal: 15,
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              child:
                                                                  AutoSizeText(
                                                                "Credit Card\n ending in ${c.lastFourDigits}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                // ,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blueGrey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          30,
                                                                          0),
                                                              child: Text(
                                                                c.isDefault !=
                                                                            null &&
                                                                        c.isDefault ==
                                                                            true
                                                                    ? "Default"
                                                                    : "",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    // fontSize: 40,
                                                                    color: Constants.optionalColor,
                                                                    fontWeight: FontWeight.w900),
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
                                              children: <Widget>[
                                                EmptyListItem("cards")
                                              ],
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
                            child: Card.Card(
                              child: InkWell(
                                onTap: () {
                                  // _pay();
                                },
                                //  Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             fullscreenDialog: true,
                                //             builder: (context) => BikeDetailScreen(widget.bike),
                                //             maintainState: false),),

                                // Navigator.of(context).pushNamed(
                                //   BikeDetailScreen.routeName,
                                //   arguments: BikeDetailScreen(bike.bikeId),
                                // ),
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  width: double.infinity,
                                  height: 85,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        // crossAxisAlignment: CrossAxisAlignment.center,

                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: Image.asset(
                                              'assets/squareinappblue.png',
                                              height: 50,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: Icon(Icons.arrow_forward,
                                                color: Constants.optionalColor),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                                builder: (context) =>
                                                    CreditCardScreen(),
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
                                        if (chooseForJourney != null &&
                                            chooseForJourney != false) {
                                          // print('gets herereererer');
                                          print(barcode);

                                          final bikesProv =
                                              Provider.of<Bikes>(context);
                                          // print(bikesProv.allBikes);
                                          final user =
                                              Provider.of<Authentication>(
                                                  context);
                                          final bike =
                                              bikesProv.findByQrCode(barcode);
                                          // print('bike : ${bike.toString()}, bikeId : ${bike.id}');
                                          final bikeId = bike.id;
                                          final bikeOwnerId = bike.userId;
                                          // print('bikeOwnerId : $bikeOwnerId, bikeId : $bikeId');
                                          var newJourney = Journey(
                                              startTime: DateTime.now(),
                                              userId: user.userId,
                                              bikeId: bikeId,
                                              bikeOwnerId: bikeOwnerId);
                                          Provider.of<Bikes>(context)
                                              .updateBike(
                                                  bikeId,
                                                  Bike(
                                                      qrCode: bike.qrCode,
                                                      lat: bike.lat,
                                                      lng: bike.lng,
                                                      name: bike.name,
                                                      model: bike.model,
                                                      isActive: true));
                                          Provider.of<Journeys>(context)
                                              .addJourney(newJourney);
                                          // Provider.of<Journeys>(context).addJourney(
                                          //   newJourney
                                          // ).then((response) {
                                          //   print('new Journey: $newJourney');
                                          //   Navigator.of(context).pushReplacementNamed(
                                          //     JourneyScreen.routeName,
                                          //     arguments: JourneyScreen(
                                          //       journey: response,
                                          //       isUserBike: (response.bikeOwnerId == response.userId)
                                          //     ),
                                          //   );
                                          // });

                                          // goto journey screen
                                          Provider.of<Journeys>(context)
                                              .getCurrentUserJourney()
                                              .then((response) {
                                            print(
                                                'response of get current journey: $response');
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                              JourneyScreen.routeName,
                                              arguments: JourneyScreen(
                                                journey: response,
                                                isUserBike:
                                                    (response.bikeOwnerId ==
                                                        response.userId),
                                                bikeId: response.bikeId,
                                              ),
                                            );
                                          });
                                        } else {
                                          Navigator.of(context).pop();
                                        }
                                        //save default card
                                        // print('update/edit bike id: $id');
                                        // bike.name = name;
                                        // bike.model = type;
                                        // bikeProv.updateBike(id, bike); //update existing bike
                                      },
                                      child: Text(
                                          chooseForJourney != null &&
                                                  chooseForJourney != false
                                              ? "Ok"
                                              : "Save",
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
                  );
                } else if (snapshot.hasError) {
                  return GenericScreen('regular', 'There was an error!', 'Ok',
                      'assets/gnglogo.png', '/login');
                }
                return SpinKitPulse(color: Constants.mainColor);
              }),
        ),
      ),
    );
  }

  Future<bool> _showDialog() async {
    bool result;
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
                    result = true;
                    Navigator.of(context).pop();
                    result = true;
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
                    result = false;
                    Navigator.of(context).pop();
                    result = false;
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
    return result;
  }
}
