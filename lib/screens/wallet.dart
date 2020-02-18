import 'package:flutter/material.dart';
import 'package:flutter_app/screens/add_credit_card.dart';
import 'package:flutter_app/screens/card_list.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;

import 'direct_deposit.dart';

class WalletScreen extends StatelessWidget {
  static final routeName = 'wallet';

  // Widget buildCard(String title, Icon icon, String tag, String route, BuildContext context) {
  //   Color greyText = Colors.blueGrey;
  //   return Hero(
  //       tag: tag,
  //       child: Card(
  //           child: InkWell(
  //           onTap: () => Navigator.push(
  //              MaterialPageRoute(
  //               fullscreenDialog: true,
  //               builder: (context) => CreditCardScreen(),
  //               maintainState: false
  //               )
  //           ),
  //           child: Container(
  //             padding: EdgeInsets.all(20),
  //             width: double.infinity,
  //             height: 200,
  //             child: Column(
  //               children: <Widget>[
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: <Widget>[
  //                     icon,
  //                     // Icon(Icons.attach_money),
  //                     Text(
  //                       title,
  //                       textAlign: TextAlign.center,
  //                       style: TextStyle(
  //                           color: greyText,
  //                           fontFamily: 'OpenSans',
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 20),
  //                     ),
  //                 ]),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //   );
  // }

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
                  'Wallet',
                  style: TextStyle(),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Card(
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => CreditCardScreen(),
                            maintainState: false)),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      height: 75,
                      child: Column(
                        children: <Widget>[
                          Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.credit_card,
                                    color: Colors.blueGrey),
                                // Icon(Icons.attach_money),
                                Expanded(
                                  child: Text(
                                    'Add Payment Method',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ),
                ),

                //   child: buildCard(
                //   'Add Payment Method',
                //   Icon(Icons.attach_money),
                //   "credit",
                //   "credit",
                //   context)
                // ),
                // Padding(
                //     padding: EdgeInsets.all(10),
                //     child:

                //         buildCard(
                //         'Enroll in Direct Deposit',
                //         Icon(Icons.account_balance_wallet),
                //         "deposit",
                //         '',
                //         context)
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Card(
                  child: InkWell(
                    onTap: () => Navigator.of(context).pushNamed(DirectDeposit.routeName),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      height: 75,
                      child: Column(
                        children: <Widget>[
                          Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.account_balance,
                                  // Icons.account_balance_wallet,
                                    color: Colors.blueGrey),
                                Expanded(
                                  child: Text(
                                    ' Enroll in Direct Deposit',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  'Default Payment Method:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Credit Card\n ending in XXXX",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontFamily: 'Comfortaa',
                                // fontWeight: FontWeight.w900,
                                fontSize: 15),
                          ),
                          OutlineButton(
                            // minWidth: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            onPressed: () {
                            //   Navigator.of(context).push(
                            //     CardScreen.routeName,
                            //     arguments: CardScreen(
                            //       chooseDefault: false,
                            //     ),
                            //   );
                            // },
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      fullscreenDialog: true,
                                      builder: (context) => CardScreen(chooseDefault: true, chooseForJourney: false),
                                      maintainState: false));
                            },
                            child: Text(
                              "Change",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Constants.mainColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),);
  }
}
