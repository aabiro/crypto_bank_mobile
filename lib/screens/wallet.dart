import 'package:flutter/material.dart';
import 'package:flutter_app/screens/add_credit_card.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;

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
                child: Hero(
                  tag: "credit",
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.attach_money, color: Colors.blueGrey),
                                  // Icon(Icons.attach_money),
                                  Text(
                                    'Add Payment Method',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ]),
                          ],
                        ),
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
                child: Hero(
                  tag: "deposit",
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.account_balance_wallet, color: Colors.blueGrey),
                                  Text(
                                    ' Enroll in Direct Deposit',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
